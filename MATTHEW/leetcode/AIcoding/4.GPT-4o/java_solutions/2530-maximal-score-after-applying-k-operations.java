class Solution {
    public int maximizeScore(int[] nums, int k) {
        int n = nums.length;
        Arrays.sort(nums);
        int left = 0, right = n - 1;
        int score = 0;

        while (k > 0 && left < right) {
            score += nums[right];
            right--;
            k--;
            if (k > 0) {
                score += nums[left];
                left++;
                k--;
            }
        }

        while (k > 0 && left < n) {
            score += nums[left];
            left++;
            k--;
        }

        return score;
    }
}