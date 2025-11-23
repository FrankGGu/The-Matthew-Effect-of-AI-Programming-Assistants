class Solution {
    public String tictactoe(int[][] moves) {
        int[] rowA = new int[3];
        int[] colA = new int[3];
        int diagA = 0;
        int antiDiagA = 0;
        int[] rowB = new int[3];
        int[] colB = new int[3];
        int diagB = 0;
        int antiDiagB = 0;

        for (int i = 0; i < moves.length; i++) {
            int row = moves[i][0];
            int col = moves[i][1];
            if (i % 2 == 0) {
                rowA[row]++;
                colA[col]++;
                if (row == col) {
                    diagA++;
                }
                if (row + col == 2) {
                    antiDiagA++;
                }
                if (rowA[row] == 3 || colA[col] == 3 || diagA == 3 || antiDiagA == 3) {
                    return "A";
                }
            } else {
                rowB[row]++;
                colB[col]++;
                if (row == col) {
                    diagB++;
                }
                if (row + col == 2) {
                    antiDiagB++;
                }
                if (rowB[row] == 3 || colB[col] == 3 || diagB == 3 || antiDiagB == 3) {
                    return "B";
                }
            }
        }

        if (moves.length == 9) {
            return "Draw";
        } else {
            return "Pending";
        }
    }
}