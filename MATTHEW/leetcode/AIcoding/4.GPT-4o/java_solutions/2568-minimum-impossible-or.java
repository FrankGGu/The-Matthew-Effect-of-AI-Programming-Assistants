class Solution {
    public int findMinimumImpossibleOR(int[] A) {
        boolean[] seen = new boolean[2001];
        for (int num : A) {
            seen[num] = true;
        }
        for (int i = 1; i < seen.length; i++) {
            if (!seen[i]) {
                return i;
            }
        }
        return -1;
    }
}