class NumArray {
    private int[] nums;
    private int[] tree;
    private int n;

    public NumArray(int[] nums) {
        this.nums = nums;
        this.n = nums.length;
        this.tree = new int[n + 1];
        for (int i = 0; i < n; i++) {
            update(i, nums[i]);
        }
    }

    public void update(int index, int val) {
        int diff = val - nums[index];
        nums[index] = val;
        index++;
        while (index <= n) {
            tree[index] += diff;
            index += index & -index;
        }
    }

    public int sumRange(int left, int right) {
        return sum(right) - sum(left - 1);
    }

    private int sum(int index) {
        int result = 0;
        index++;
        while (index > 0) {
            result += tree[index];
            index -= index & -index;
        }
        return result;
    }
}