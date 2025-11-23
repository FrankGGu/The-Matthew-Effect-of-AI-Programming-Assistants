class Solution {
    public int[] constructArray(int n, int k) {
        int[] result = new int[n];
        int left = 1;
        int right = k + 1;
        int index = 0;
        while (left <= right) {
            result[index++] = left++;
            if (left <= right) {
                result[index++] = right--;
            }
        }
        for (int i = k + 2; i <= n; i++) {
            result[index++] = i;
        }
        return result;
    }
}