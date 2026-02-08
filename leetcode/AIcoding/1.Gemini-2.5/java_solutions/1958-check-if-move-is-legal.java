class Solution {
    public boolean checkMove(char[][] board, int rMove, int cMove, char color) {
        int[] dr = {-1, -1, -1, 0, 0, 1, 1, 1};
        int[] dc = {-1, 0, 1, -1, 1, -1, 0, 1};

        for (int i = 0; i < 8; i++) {
            int currR = rMove + dr[i];
            int currC = cMove + dc[i];
            int opponentPiecesCount = 0;

            while (currR >= 0 && currR < 8 && currC >= 0 && currC < 8) {
                char currentCell = board[currR][currC];

                if (currentCell == '.') {
                    break; 
                }

                if (currentCell == color) { 
                    if (opponentPiecesCount > 0) {
                        return true; 
                    } else {
                        break; 
                    }
                } else { 
                    opponentPiecesCount++;
                }

                currR += dr[i];
                currC += dc[i];
            }
        }

        return false; 
    }
}