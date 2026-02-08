class Solution {
    public int maxWidthRamp(int[] nums) {
        int n = nums.length;
        Integer[] indices = new Integer[n];
        for (int i = 0; i < n; i++) {
            indices[i] = i;
        }
        Arrays.sort(indices, (i, j) -> Integer.compare(nums[i], nums[j]));
        int minIndex = n;
        int res = 0;
        for (int i : indices) {
            res = Math.max(res, i - minIndex);
            minIndex = Math.min(minIndex, i);
        }
        return res;
    }
}