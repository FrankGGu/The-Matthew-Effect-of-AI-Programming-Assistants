class Solution {
    public int getWinner(int[] arr, int k) {
        int currentWinner = arr[0];
        int winCount = 0;

        for (int i = 1; i < arr.length; i++) {
            if (currentWinner > arr[i]) {
                winCount++;
            } else {
                currentWinner = arr[i];
                winCount = 1;
            }

            if (winCount == k) {
                break;
            }
        }

        return currentWinner;
    }
}