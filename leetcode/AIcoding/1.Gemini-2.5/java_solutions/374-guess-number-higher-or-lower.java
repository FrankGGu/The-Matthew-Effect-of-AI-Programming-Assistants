public class Solution extends GuessGame {
    public int guessNumber(int n) {
        int low = 1;
        int high = n;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            int result = guess(mid);

            if (result == 0) {
                return mid;
            } else if (result == -1) { // My guess is higher than the pick
                high = mid - 1;
            } else { // My guess is lower than the pick
                low = mid + 1;
            }
        }
        return -1; // Should not reach here given the problem constraints
    }
}