class Solution {
    public int[] fillMissingData(int[] data) {
        int n = data.length;
        for (int i = 0; i < n; i++) {
            if (data[i] == -1) {
                int left = (i > 0) ? data[i - 1] : 0;
                int right = (i < n - 1) ? data[i + 1] : 0;
                data[i] = (left + right) / 2;
            }
        }
        return data;
    }
}