class Solution {
    public int[] getFinalArray(int n, int k, int[] queries) {
        int[] arr = new int[n];
        for (int query : queries) {
            for (int i = 0; i < n; i++) {
                if ((i + 1) % (query + 1) == 0) {
                    arr[i] *= k;
                }
            }
        }
        return arr;
    }
}