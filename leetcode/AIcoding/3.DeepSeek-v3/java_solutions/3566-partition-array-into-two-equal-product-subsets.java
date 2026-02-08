class Solution {
    public boolean canPartition(int[] nums) {
        int totalProduct = 1;
        for (int num : nums) {
            totalProduct *= num;
        }
        if (totalProduct == 0) {
            for (int num : nums) {
                if (num == 0) {
                    return true;
                }
            }
            return false;
        }
        if (totalProduct < 0) {
            totalProduct = -totalProduct;
        }
        return helper(nums, 0, 1, totalProduct);
    }

    private boolean helper(int[] nums, int index, int currentProduct, int totalProduct) {
        if (currentProduct * currentProduct > totalProduct) {
            return false;
        }
        if (currentProduct * currentProduct == totalProduct) {
            return true;
        }
        for (int i = index; i < nums.length; i++) {
            if (helper(nums, i + 1, currentProduct * nums[i], totalProduct)) {
                return true;
            }
        }
        return false;
    }
}