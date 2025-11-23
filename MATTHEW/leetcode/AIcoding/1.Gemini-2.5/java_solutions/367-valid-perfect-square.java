class Solution {
    public boolean isPerfectSquare(int num) {
        if (num < 1) {
            return false;
        }
        if (num == 1) {
            return true;
        }

        long low = 1;
        long high = num; 

        while (low <= high) {
            long mid = low + (high - low) / 2;
            long midSquared = mid * mid;

            if (midSquared == num) {
                return true;
            } else if (midSquared < num) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return false;
    }
}