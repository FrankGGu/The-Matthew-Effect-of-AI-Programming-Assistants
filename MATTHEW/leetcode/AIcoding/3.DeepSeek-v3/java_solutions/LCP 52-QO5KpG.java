class Solution {
    public int maxCount(int[] nums, int k) {
        Arrays.sort(nums);
        int count = 0;
        long sum = 0;
        for (int num : nums) {
            if (sum + num > k) {
                break;
            }
            sum += num;
            count++;
        }
        return count;
    }
}