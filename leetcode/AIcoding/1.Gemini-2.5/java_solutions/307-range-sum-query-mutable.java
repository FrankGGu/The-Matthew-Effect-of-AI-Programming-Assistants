class NumArray {
    private int[] nums;
    private int[] bit; // Fenwick Tree (Binary Indexed Tree)
    private int n;

    public NumArray(int[] nums) {
        this.n = nums.length;
        this.nums = new int[n]; // Store a copy of the original array
        this.bit = new int[n + 1]; // Fenwick tree is 1-indexed

        // Initialize the Fenwick tree by adding each element
        for (int i = 0; i < n; i++) {
            this.nums[i] = nums[i]; // Copy original value
            updateBit(i + 1, nums[i]); // Add to Fenwick tree
        }
    }

    // Helper to update the Fenwick tree
    // idx is 1-indexed, val is the difference to add
    private void updateBit(int idx, int val) {
        while (idx <= n) {
            bit[idx] += val;
            idx += idx & (-idx); // Move to the next parent
        }
    }

    // Helper to query prefix sum from Fenwick tree
    // idx is 1-indexed
    private int queryBit(int idx) {
        int sum = 0;
        while (idx > 0) {
            sum += bit[idx];
            idx -= idx & (-idx); // Move to the previous parent
        }
        return sum;
    }

    public void update(int index, int val) {
        // Calculate the difference between the new value and the old value
        int diff = val - nums[index];
        // Update the original array
        nums[index] = val;
        // Update the Fenwick tree with the difference
        updateBit(index + 1, diff);
    }

    public int sumRange(int left, int right) {
        // sumRange(left, right) = prefixSum(right) - prefixSum(left - 1)
        // Convert 0-indexed 'right' and 'left-1' to 1-indexed for queryBit
        return queryBit(right + 1) - queryBit(left);
    }
}