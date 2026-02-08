class Solution {
    public long countOperationsToEmptyArray(int[] nums) {
        int n = nums.length;
        int[] sortedIndices = new int[n];
        for (int i = 0; i < n; i++) {
            sortedIndices[i] = i;
        }
        Integer[] indices = new Integer[n];
        for (int i = 0; i < n; i++) {
            indices[i] = i;
        }
        Arrays.sort(indices, (a, b) -> Integer.compare(nums[a], nums[b]));

        long res = n;
        for (int i = 1; i < n; i++) {
            if (indices[i] < indices[i - 1]) {
                res += n - i;
            }
        }
        return res;
    }
}