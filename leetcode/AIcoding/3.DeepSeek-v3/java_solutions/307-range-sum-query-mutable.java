class NumArray {
    private int[] nums;
    private int[] tree;
    private int n;

    public NumArray(int[] nums) {
        this.n = nums.length;
        this.nums = nums;
        this.tree = new int[n + 1];
        for (int i = 0; i < n; i++) {
            updateTree(i + 1, nums[i]);
        }
    }

    private void updateTree(int index, int val) {
        while (index <= n) {
            tree[index] += val;
            index += index & -index;
        }
    }

    public void update(int index, int val) {
        int delta = val - nums[index];
        nums[index] = val;
        updateTree(index + 1, delta);
    }

    private int query(int index) {
        int sum = 0;
        while (index > 0) {
            sum += tree[index];
            index -= index & -index;
        }
        return sum;
    }

    public int sumRange(int left, int right) {
        return query(right + 1) - query(left);
    }
}