class Solution {
    public int[] xorQueries(int[] arr, int[][] queries) {
        int n = arr.length;
        int m = queries.length;
        int[] prefixXor = new int[n + 1];
        prefixXor[0] = 0;
        for (int i = 1; i <= n; i++) {
            prefixXor[i] = prefixXor[i - 1] ^ arr[i - 1];
        }

        int[] result = new int[m];
        for (int i = 0; i < m; i++) {
            int left = queries[i][0];
            int right = queries[i][1];
            result[i] = prefixXor[right + 1] ^ prefixXor[left];
        }

        return result;
    }
}