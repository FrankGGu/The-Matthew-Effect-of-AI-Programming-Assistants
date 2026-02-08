public class Solution {
    public int getWinner(int[] arr, int k) {
        int n = arr.length;
        int currentWinner = arr[0];
        int consecutiveWins = 0;

        for (int i = 1; i < n; i++) {
            if (currentWinner > arr[i]) {
                consecutiveWins++;
            } else {
                currentWinner = arr[i];
                consecutiveWins = 1;
            }

            if (consecutiveWins == k) {
                return currentWinner;
            }
        }

        return currentWinner;
    }
}