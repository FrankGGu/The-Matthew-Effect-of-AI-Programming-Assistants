class Solution {
    public int[] finalArray(int[] nums, int[][] operations) {
        for (int[] op : operations) {
            nums[op[0]] *= op[1];
        }
        return nums;
    }
}