class Solution {
    public int minMovesToCaptureTheQueen(int rR, int cR, int rB, int cB, int rQ, int cQ) {
        int rookMoves = 2;

        if (rR == rQ) {
            rookMoves = 1;
            if (rB == rR && ((cR < cB && cB < cQ) || (cQ < cB && cB < cR))) {
                rookMoves = 2;
            }
        } else if (cR == cQ) {
            rookMoves = 1;
            if (cB == cR && ((rR < rB && rB < rQ) || (rQ < rB && rB < rR))) {
                rookMoves = 2;
            }
        }

        int bishopMoves = 2;

        if (Math.abs(rB - rQ) == Math.abs(cB - cQ)) {
            bishopMoves = 1;
            if (Math.abs(rR - rB) == Math.abs(cR - cB) && 
                Math.abs(rR - rQ) == Math.abs(cR - cQ) && 
                ((rR > rB && rR < rQ) || (rR < rB && rR > rQ))) {
                bishopMoves = 2;
            }
        }

        return Math.min(rookMoves, bishopMoves);
    }
}