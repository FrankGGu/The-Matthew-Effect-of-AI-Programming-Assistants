class Solution {
    public long maxBalancedSubsequenceSum(int[] nums) {
        int n = nums.length;
        int[] indices = new int[n];
        for (int i = 0; i < n; i++) {
            indices[i] = i;
        }
        Integer[] sortedIndices = new Integer[n];
        for (int i = 0; i < n; i++) {
            sortedIndices[i] = i;
        }
        Arrays.sort(sortedIndices, (a, b) -> {
            int valA = nums[a] - a;
            int valB = nums[b] - b;
            if (valA != valB) {
                return Integer.compare(valA, valB);
            } else {
                return Integer.compare(a, b);
            }
        });
        long[] dp = new long[n];
        for (int i = 0; i < n; i++) {
            dp[i] = nums[i];
        }
        FenwickTree ft = new FenwickTree(n);
        long maxSum = Long.MIN_VALUE;
        for (int i = 0; i < n; i++) {
            int idx = sortedIndices[i];
            long currentMax = ft.query(idx + 1) + nums[idx];
            dp[idx] = Math.max(dp[idx], currentMax);
            ft.update(idx + 1, dp[idx]);
            maxSum = Math.max(maxSum, dp[idx]);
        }
        return maxSum;
    }

    class FenwickTree {
        long[] tree;
        int size;

        public FenwickTree(int size) {
            this.size = size;
            tree = new long[size + 1];
        }

        public void update(int index, long value) {
            while (index <= size) {
                tree[index] = Math.max(tree[index], value);
                index += index & -index;
            }
        }

        public long query(int index) {
            long res = 0;
            while (index > 0) {
                res = Math.max(res, tree[index]);
                index -= index & -index;
            }
            return res;
        }
    }
}