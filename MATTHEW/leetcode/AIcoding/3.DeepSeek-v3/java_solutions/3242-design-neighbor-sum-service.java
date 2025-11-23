class NumArray {
    private int[] nums;
    private int[] prefixSum;

    public NumArray(int[] nums) {
        this.nums = nums;
        this.prefixSum = new int[nums.length + 1];
        for (int i = 0; i < nums.length; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }
    }

    public void update(int index, int val) {
        int diff = val - nums[index];
        nums[index] = val;
        for (int i = index + 1; i < prefixSum.length; i++) {
            prefixSum[i] += diff;
        }
    }

    public int sumRange(int left, int right) {
        return prefixSum[right + 1] - prefixSum[left];
    }
}