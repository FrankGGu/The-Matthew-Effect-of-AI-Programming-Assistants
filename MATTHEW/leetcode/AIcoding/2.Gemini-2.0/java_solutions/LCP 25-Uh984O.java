class Solution {
    public int printViruses(int n, int m, int[] viruses) {
        boolean[] infected = new boolean[n + 1];
        for (int virus : viruses) {
            infected[virus] = true;
        }

        int count = 0;
        for (int i = 1; i <= n; i++) {
            if (!infected[i]) {
                count++;
            }
        }
        return count;
    }
}