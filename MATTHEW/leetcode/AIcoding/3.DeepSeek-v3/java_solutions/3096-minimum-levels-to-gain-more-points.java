class Solution {
    public int minimumLevels(int[] possible) {
        int n = possible.length;
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + (possible[i] == 1 ? 1 : -1);
        }
        int total = prefix[n];
        for (int i = 1; i < n; i++) {
            int daniel = prefix[i];
            int bob = total - daniel;
            if (daniel > bob) {
                return i;
            }
        }
        return -1;
    }
}