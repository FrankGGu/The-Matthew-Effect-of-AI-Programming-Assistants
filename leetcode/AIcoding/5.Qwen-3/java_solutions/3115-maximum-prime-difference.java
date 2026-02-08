public class Solution {
    public int maxPrimeDifference(int[] nums) {
        int n = nums.length;
        int left = 0;
        int right = n - 1;

        while (left < n && !isPrime(nums[left])) {
            left++;
        }

        while (right >= 0 && !isPrime(nums[right])) {
            right--;
        }

        return right - left;
    }

    private boolean isPrime(int num) {
        if (num < 2) {
            return false;
        }
        for (int i = 2; i * i <= num; i++) {
            if (num % i == 0) {
                return false;
            }
        }
        return true;
    }
}