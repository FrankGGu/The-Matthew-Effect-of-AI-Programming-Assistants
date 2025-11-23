class Solution {
    public int[] solve(int n, int[][] queries) {
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int x = queries[i][0];
            int y = queries[i][1];
            int a = queries[i][2];
            int b = queries[i][3];
            int count = 0;
            for (int j = 0; j < n - a + 1; j++) {
                for (int k = 0; k < n - b + 1; k++) {
                    if (j <= x && x < j + a && k <= y && y < k + b) {
                        count++;
                    }
                }
            }
            result[i] = count;
        }
        return result;
    }
}