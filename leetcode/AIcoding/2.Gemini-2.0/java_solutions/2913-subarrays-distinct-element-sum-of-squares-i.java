class Solution {
    public int sumCounts(int[] nums) {
        int n = nums.length;
        int ans = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                int[] subarray = new int[j - i + 1];
                System.arraycopy(nums, i, subarray, 0, j - i + 1);

                java.util.HashSet<Integer> distinctElements = new java.util.HashSet<>();
                for (int num : subarray) {
                    distinctElements.add(num);
                }
                int distinctCount = distinctElements.size();
                ans += distinctCount * distinctCount;
            }
        }
        return ans;
    }
}