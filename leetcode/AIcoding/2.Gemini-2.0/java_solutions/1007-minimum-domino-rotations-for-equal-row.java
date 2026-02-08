class Solution {
    public int minDominoRotations(int[] tops, int[] bottoms) {
        int n = tops.length;
        int rotationsA = getRotations(tops[0], tops, bottoms, n);
        if (rotationsA != -1) return rotationsA;
        return getRotations(bottoms[0], tops, bottoms, n);
    }

    private int getRotations(int target, int[] tops, int[] bottoms, int n) {
        int rotationsTop = 0;
        int rotationsBottom = 0;
        for (int i = 0; i < n; i++) {
            if (tops[i] != target && bottoms[i] != target) return -1;
            else if (tops[i] != target) rotationsTop++;
            else if (bottoms[i] != target) rotationsBottom++;
        }
        return Math.min(rotationsTop, rotationsBottom);
    }
}