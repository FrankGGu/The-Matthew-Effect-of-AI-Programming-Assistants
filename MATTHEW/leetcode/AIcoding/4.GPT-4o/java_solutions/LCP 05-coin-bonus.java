class Solution {
    public int maxCoins(int[] piles) {
        Arrays.sort(piles);
        int n = piles.length / 3;
        int total = 0;
        for (int i = n; i < 2 * n; i++) {
            total += piles[i];
        }
        return total;
    }
}