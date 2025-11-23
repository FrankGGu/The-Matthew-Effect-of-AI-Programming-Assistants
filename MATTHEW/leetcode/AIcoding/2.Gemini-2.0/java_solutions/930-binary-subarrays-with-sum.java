class Solution {
    public int numSubarraysWithSum(int[] nums, int goal) {
        int sum = 0;
        int count = 0;
        int[] map = new int[nums.length + 1];
        map[0] = 1;

        for (int num : nums) {
            sum += num;
            if (sum >= goal) {
                count += map[sum - goal];
            }
            map[sum]++;
        }

        return count;
    }
}