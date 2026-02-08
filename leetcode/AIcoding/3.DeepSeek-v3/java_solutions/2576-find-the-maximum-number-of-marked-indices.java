class Solution {
    public int maxNumOfMarkedIndices(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int left = 0;
        int right = n / 2;
        int res = 0;
        while (left < n / 2 && right < n) {
            if (nums[left] * 2 <= nums[right]) {
                res++;
                left++;
                right++;
            } else {
                right++;
            }
        }
        return res * 2;
    }
}