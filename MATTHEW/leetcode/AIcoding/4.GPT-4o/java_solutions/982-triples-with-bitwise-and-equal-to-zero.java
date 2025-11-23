class Solution {
    public int countTriplets(int[] nums) {
        int count = 0;
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k < n; k++) {
                    if ((nums[i] & nums[j] & nums[k]) == 0) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
}