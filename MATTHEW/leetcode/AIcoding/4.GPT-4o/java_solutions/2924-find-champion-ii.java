class Solution {
    public int findChampion(int n, int[][] matches) {
        int[] lossCount = new int[n + 1];
        for (int[] match : matches) {
            lossCount[match[1]]++;
        }

        int champion = -1;
        for (int i = 1; i <= n; i++) {
            if (lossCount[i] == 0) {
                if (champion == -1) {
                    champion = i;
                } else {
                    return -1;
                }
            }
        }

        return champion;
    }
}