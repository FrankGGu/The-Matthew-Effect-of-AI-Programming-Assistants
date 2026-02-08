class Solution {
    public int findSmallestInteger(int n, int[] value, int[] operation) {
        int[] count = new int[n + 1];
        for (int i = 0; i < value.length; i++) {
            count[value[i]] += operation[i];
        }

        for (int i = 0; i <= n; i++) {
            if (count[i] <= 0) {
                return i;
            }
        }

        return n + 1;
    }
}