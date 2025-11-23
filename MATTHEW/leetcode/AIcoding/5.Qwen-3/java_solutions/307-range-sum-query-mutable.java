public class NumArray {
    private int[] tree;
    private int[] nums;
    private int size;

    public NumArray(int[] nums) {
        this.nums = nums;
        size = nums.length;
        tree = new int[size + 1];
        for (int i = 0; i < size; i++) {
            updateTree(i, nums[i]);
        }
    }

    private void updateTree(int index, int value) {
        index += 1;
        while (index <= size) {
            tree[index] += value;
            index += index & -index;
        }
    }

    public void update(int index, int val) {
        int diff = val - nums[index];
        nums[index] = val;
        updateTree(index, diff);
    }

    public int sumRange(int left, int right) {
        return query(right) - query(left - 1);
    }

    private int query(int index) {
        index += 1;
        int res = 0;
        while (index > 0) {
            res += tree[index];
            index -= index & -index;
        }
        return res;
    }
}