import java.util.Arrays;

class Solution {
    public long maxRunTime(int n, int[] batteries) {
        Arrays.sort(batteries);
        long sum = 0;
        for (int battery : batteries) {
            sum += battery;
        }

        int k = batteries.length - n;
        for (int i = 0; i < k; i++) {
            sum -= batteries[i];
        }

        long possibleMax = sum / n;

        for (int i = batteries.length - 1; i >= batteries.length - n; i--) {
            if (batteries[i] > possibleMax) {
                return possibleMax;
            }
        }

        return possibleMax;
    }
}