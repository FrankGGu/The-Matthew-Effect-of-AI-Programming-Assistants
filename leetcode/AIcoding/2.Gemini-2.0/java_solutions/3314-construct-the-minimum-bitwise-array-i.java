class Solution {
    public int[] constructBitwiseArray(int[] arr) {
        int n = arr.length;
        int[] result = new int[n];
        if (n == 1) {
            result[0] = 0;
            return result;
        }
        result[0] = arr[0] & arr[1];
        result[n - 1] = arr[n - 2] & arr[n - 1];
        for (int i = 1; i < n - 1; i++) {
            result[i] = arr[i - 1] & arr[i + 1];
        }
        return result;
    }
}