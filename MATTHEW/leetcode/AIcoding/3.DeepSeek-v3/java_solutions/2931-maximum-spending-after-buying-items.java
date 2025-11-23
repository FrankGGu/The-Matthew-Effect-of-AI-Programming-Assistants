class Solution {
    public long maxSpending(int[][] values) {
        int m = values.length;
        int n = values[0].length;
        int[] arr = new int[m * n];
        int idx = 0;
        for (int[] row : values) {
            for (int num : row) {
                arr[idx++] = num;
            }
        }
        Arrays.sort(arr);
        long res = 0;
        for (int i = 0; i < arr.length; i++) {
            res += (long) arr[i] * (i + 1);
        }
        return res;
    }
}