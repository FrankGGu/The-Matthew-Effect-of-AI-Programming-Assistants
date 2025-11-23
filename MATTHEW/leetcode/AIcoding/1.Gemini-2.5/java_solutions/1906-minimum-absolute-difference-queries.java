class Solution {
    public int[] minDifference(int[] nums, int[][] queries) {
        int n = nums.length;
        int[][] prefixCount = new int[n + 1][101];

        for (int i = 0; i < n; i++) {
            for (int j = 1; j <= 100; j++) {
                prefixCount[i + 1][j] = prefixCount[i][j];
            }
            prefixCount[i + 1][nums[i]]++;
        }

        int[] result = new int[queries.length];
        for (int q = 0; q < queries.length; q++) {
            int left = queries[q][0];
            int right = queries[q][1];

            java.util.List<Integer> presentNumbers = new java.util.ArrayList<>();
            for (int val = 1; val <= 100; val++) {
                int count = prefixCount[right + 1][val] - prefixCount[left][val];
                if (count > 0) {
                    presentNumbers.add(val);
                }
            }

            if (presentNumbers.size() < 2) {
                result[q] = -1;
            } else {
                int minDiff = Integer.MAX_VALUE;
                for (int i = 1; i < presentNumbers.size(); i++) {
                    minDiff = Math.min(minDiff, presentNumbers.get(i) - presentNumbers.get(i - 1));
                }
                result[q] = minDiff;
            }
        }

        return result;
    }
}