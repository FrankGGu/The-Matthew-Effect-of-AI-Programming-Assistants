class Solution {
    public boolean xorQueries(int[] arr, int[][] queries) {
        int n = arr.length;
        int[] prefixXor = new int[n + 1];

        for (int i = 0; i < n; i++) {
            prefixXor[i + 1] = prefixXor[i] ^ arr[i];
        }

        for (int[] query : queries) {
            int left = query[0], right = query[1];
            if (prefixXor[right + 1] ^ prefixXor[left] != 0) {
                return false;
            }
        }

        return true;
    }
}