public class Solution {
    public int smallestDivisor(int[] nums, int threshold) {
        int left = 1;
        int right = 1000000;

        while (left < right) {
            int mid = left + (right - left) / 2;
            int sum = 0;
            for (int num : nums) {
                sum += Math.ceil((double) num / mid);
            }
            if (sum > threshold) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
}