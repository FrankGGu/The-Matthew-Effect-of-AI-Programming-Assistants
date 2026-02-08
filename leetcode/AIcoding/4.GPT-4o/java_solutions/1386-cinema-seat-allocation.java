class Solution {
    public int maxProfit(int n, int[][] reservedSeats) {
        boolean[][] seats = new boolean[10][10];
        for (int[] seat : reservedSeats) {
            seats[seat[0] - 1][seat[1] - 1] = true;
        }

        int profit = 0;
        for (int i = 0; i < n; i++) {
            if (seats[i][1] == false && seats[i][2] == false && seats[i][3] == false) {
                profit += 3;
                seats[i][1] = true;
                seats[i][2] = true;
                seats[i][3] = true;
            } else if (seats[i][2] == false && seats[i][3] == false) {
                profit += 2;
                seats[i][2] = true;
                seats[i][3] = true;
            } else if (seats[i][3] == false) {
                profit += 1;
                seats[i][3] = true;
            }

            if (i == n - 1) continue;
            if (seats[i][5] == false && seats[i][6] == false && seats[i][7] == false) {
                profit += 3;
                seats[i][5] = true;
                seats[i][6] = true;
                seats[i][7] = true;
            } else if (seats[i][6] == false && seats[i][7] == false) {
                profit += 2;
                seats[i][6] = true;
                seats[i][7] = true;
            } else if (seats[i][7] == false) {
                profit += 1;
                seats[i][7] = true;
            }
        }

        return profit;
    }
}