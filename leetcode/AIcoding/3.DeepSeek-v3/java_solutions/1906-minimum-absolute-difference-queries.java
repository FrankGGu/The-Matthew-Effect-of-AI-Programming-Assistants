class Solution {
    public int[] minDifference(int[] nums, int[][] queries) {
        int n = nums.length;
        int[][] prefix = new int[n + 1][101];
        for (int i = 0; i < n; i++) {
            for (int j = 1; j <= 100; j++) {
                prefix[i + 1][j] = prefix[i][j];
            }
            prefix[i + 1][nums[i]]++;
        }

        int[] res = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int left = queries[i][0];
            int right = queries[i][1];
            List<Integer> present = new ArrayList<>();
            for (int j = 1; j <= 100; j++) {
                if (prefix[right + 1][j] - prefix[left][j] > 0) {
                    present.add(j);
                }
            }
            int minDiff = Integer.MAX_VALUE;
            for (int k = 1; k < present.size(); k++) {
                minDiff = Math.min(minDiff, present.get(k) - present.get(k - 1));
            }
            res[i] = present.size() == 1 ? -1 : minDiff;
        }
        return res;
    }
}