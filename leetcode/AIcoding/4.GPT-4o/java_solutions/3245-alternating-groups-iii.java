class Solution {
    public int[] alternatingGroups(int n) {
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = (i % 2 == 0) ? (i / 2 + 1) : ((n + i) / 2 + 1);
        }
        return result;
    }
}