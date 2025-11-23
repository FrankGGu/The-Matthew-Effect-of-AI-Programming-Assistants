import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    private int numPieces;
    private List<Set<Integer>> allPossibleMoves;
    private int count;

    public int countCombinations(String[] pieces, int[][] positions) {
        numPieces = pieces.length;
        allPossibleMoves = new ArrayList<>();
        count = 0;

        for (int i = 0; i < numPieces; i++) {
            int r = positions[i][0] - 1;
            int c = positions[i][1] - 1;
            allPossibleMoves.add(generateMoves(pieces[i], r, c));
        }

        backtrack(0, new HashSet<>());
        return count;
    }

    private Set<Integer> generateMoves(String pieceType, int r, int c) {
        Set<Integer> moves = new HashSet<>();
        moves.add(r * 8 + c);

        switch (pieceType) {
            case "rook":
                addRookMoves(r, c, moves);
                break;
            case "bishop":
                addBishopMoves(r, c, moves);
                break;
            case "queen":
                addRookMoves(r, c, moves);
                addBishopMoves(r, c, moves);
                break;
        }
        return moves;
    }

    private void addRookMoves(int r, int c, Set<Integer> moves) {
        for (int col = 0; col < 8; col++) {
            moves.add(r * 8 + col);
        }
        for (int row = 0; row < 8; row++) {
            moves.add(row * 8 + c);
        }
    }

    private void addBishopMoves(int r, int c, Set<Integer> moves) {
        for (int k = -7; k <= 7; k++) {
            if (k == 0) continue; 
            int nr = r + k;
            int nc = c + k;
            if (nr >= 0 && nr < 8 && nc >= 0 && nc < 8) {
                moves.add(nr * 8 + nc);
            }
        }
        for (int k = -7; k <= 7; k++) {
            if (k == 0) continue;
            int nr = r + k;
            int nc = c - k;
            if (nr >= 0 && nr < 8 && nc >= 0 && nc < 8) {
                moves.add(nr * 8 + nc);
            }
        }
    }

    private void backtrack(int pieceIdx, Set<Integer> currentOccupiedSquares) {
        if (pieceIdx == numPieces) {
            count++;
            return;
        }

        Set<Integer> possibleMovesForCurrentPiece = allPossibleMoves.get(pieceIdx);
        for (int move : possibleMovesForCurrentPiece) {
            if (!currentOccupiedSquares.contains(move)) {
                currentOccupiedSquares.add(move);
                backtrack(pieceIdx + 1, currentOccupiedSquares);
                currentOccupiedSquares.remove(move);
            }
        }
    }
}