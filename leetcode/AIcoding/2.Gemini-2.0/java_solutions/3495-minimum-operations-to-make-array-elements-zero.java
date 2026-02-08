class Solution {
    public int minimumOperations(int[] nums) {
        int count = 0;
        while (true) {
            int minPositive = Integer.MAX_VALUE;
            boolean allZero = true;
            for (int num : nums) {
                if (num > 0) {
                    allZero = false;
                    minPositive = Math.min(minPositive, num);
                }
            }
            if (allZero) {
                break;
            }
            count++;
            for (int i = 0; i < nums.length; i++) {
                if (nums[i] > 0) {
                    nums[i] -= minPositive;
                }
            }
        }
        return count;
    }
}