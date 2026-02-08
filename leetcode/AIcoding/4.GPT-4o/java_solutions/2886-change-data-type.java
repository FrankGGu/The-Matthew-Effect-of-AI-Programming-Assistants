class Solution {
    public int[] changeDataType(int[] arr) {
        int n = arr.length;
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = arr[i] * arr[i];
        }
        return result;
    }
}