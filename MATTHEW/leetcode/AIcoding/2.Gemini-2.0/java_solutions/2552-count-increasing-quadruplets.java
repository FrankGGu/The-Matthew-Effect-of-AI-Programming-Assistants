class Solution {
    public long countQuadruplets(int[] nums) {
        int n = nums.length;
        long count = 0;
        for (int j = 1; j < n - 2; j++) {
            for (int k = j + 1; k < n - 1; k++) {
                if (nums[j] > nums[k]) {
                    int less = 0;
                    for (int i = 0; i < j; i++) {
                        if (nums[i] < nums[k]) {
                            less++;
                        }
                    }
                    int greater = 0;
                    for (int l = k + 1; l < n; l++) {
                        if (nums[l] > nums[j]) {
                            greater++;
                        }
                    }
                    count += (long) less * greater;
                }
            }
        }
        return count;
    }
}