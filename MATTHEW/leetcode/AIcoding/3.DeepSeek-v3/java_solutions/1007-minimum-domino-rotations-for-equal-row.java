class Solution {
    public int minDominoRotations(int[] tops, int[] bottoms) {
        int n = tops.length;
        int[] countTop = new int[7];
        int[] countBottom = new int[7];
        int[] same = new int[7];

        for (int i = 0; i < n; i++) {
            countTop[tops[i]]++;
            countBottom[bottoms[i]]++;
            if (tops[i] == bottoms[i]) {
                same[tops[i]]++;
            }
        }

        for (int i = 1; i <= 6; i++) {
            if (countTop[i] + countBottom[i] - same[i] >= n) {
                return Math.min(countTop[i], countBottom[i]) - same[i];
            }
        }

        return -1;
    }
}