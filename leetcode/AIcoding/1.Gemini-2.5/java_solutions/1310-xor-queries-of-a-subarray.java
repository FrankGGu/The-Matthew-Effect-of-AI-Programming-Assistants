class Solution {
    public int[] xorQueries(int[] arr, int[][] queries) {
        int n = arr.length;
        int[] prefixXor = new int[n + 1];
        prefixXor[0] = 0;
        for (int i = 0; i < n; i++) {
            prefixXor[i + 1] = prefixXor[i] ^ arr[i];
        }

        int[] results = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int L = queries[i][0];
            int R = queries[i][1];
            results[i] = prefixXor[R + 1] ^ prefixXor[L];
        }

        return results;
    }
}