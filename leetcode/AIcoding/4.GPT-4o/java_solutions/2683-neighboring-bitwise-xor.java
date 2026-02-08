class Solution {
    public int[] findNeighboredXor(int[] arr) {
        int n = arr.length;
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            int left = (i > 0) ? arr[i - 1] : 0;
            int right = (i < n - 1) ? arr[i + 1] : 0;
            result[i] = left ^ right;
        }
        return result;
    }
}