class Solution {
    public int getWinner(int[] arr, int k) {
        int winner = arr[0];
        int winCount = 0;
        for (int i = 1; i < arr.length; i++) {
            if (winner > arr[i]) {
                winCount++;
            } else {
                winner = arr[i];
                winCount = 1;
            }
            if (winCount == k) {
                return winner;
            }
        }
        return winner;
    }
}