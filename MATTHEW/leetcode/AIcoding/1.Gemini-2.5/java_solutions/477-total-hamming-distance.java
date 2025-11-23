class Solution {
    public int totalHammingDistance(int[] nums) {
        int totalDistance = 0;
        int n = nums.length;

        for (int i = 0; i < 32; i++) {
            int count0 = 0;
            int count1 = 0;
            for (int j = 0; j < n; j++) {
                if (((nums[j] >> i) & 1) == 0) {
                    count0++;
                } else {
                    count1++;
                }
            }
            totalDistance += count0 * count1;
        }

        return totalDistance;
    }
}