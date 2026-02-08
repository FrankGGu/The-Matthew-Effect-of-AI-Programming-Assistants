class Solution {
    public String tictactoe(int[][] moves) {
        int[] rows = new int[3];
        int[] cols = new int[3];
        int diag1 = 0, diag2 = 0;
        int player = 1;

        for (int[] move : moves) {
            int row = move[0];
            int col = move[1];

            rows[row] += player;
            cols[col] += player;

            if (row == col) {
                diag1 += player;
            }
            if (row + col == 2) {
                diag2 += player;
            }

            if (Math.abs(rows[row]) == 3 || Math.abs(cols[col]) == 3 || 
                Math.abs(diag1) == 3 || Math.abs(diag2) == 3) {
                return player == 1 ? "A" : "B";
            }

            player *= -1;
        }

        return moves.length == 9 ? "Draw" : "Pending";
    }
}