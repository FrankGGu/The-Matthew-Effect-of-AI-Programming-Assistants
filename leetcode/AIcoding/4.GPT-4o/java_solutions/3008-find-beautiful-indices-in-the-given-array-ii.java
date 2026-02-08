class Solution {
    public List<Integer> beautifulIndices(int[] nums) {
        List<Integer> result = new ArrayList<>();
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            if (isBeautiful(nums, i)) {
                result.add(i);
            }
        }
        return result;
    }

    private boolean isBeautiful(int[] nums, int index) {
        int leftSum = 0, rightSum = 0;
        for (int i = 0; i < index; i++) {
            leftSum += nums[i];
        }
        for (int i = index + 1; i < nums.length; i++) {
            rightSum += nums[i];
        }
        return leftSum == rightSum;
    }
}