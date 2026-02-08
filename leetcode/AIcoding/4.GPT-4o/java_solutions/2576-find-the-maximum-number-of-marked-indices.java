class Solution {
    public int maxNumOfMarkedIndices(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int count = 0;
        for (int i = 0; i < n / 2; i++) {
            if (nums[i] * 2 <= nums[n - i - 1]) {
                count += 2;
            }
        }
        return count + (n % 2 == 1 ? 1 : 0);
    }
}