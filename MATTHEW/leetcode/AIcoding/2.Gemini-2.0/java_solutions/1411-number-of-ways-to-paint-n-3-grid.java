class Solution {
    public int numOfWays(int n) {
        long twoColors = 6;
        long threeColors = 6;
        long mod = 1000000007;

        for (int i = 1; i < n; i++) {
            long newTwoColors = (twoColors * 3 + threeColors * 2) % mod;
            long newThreeColors = (twoColors * 2 + threeColors * 2) % mod;
            twoColors = newTwoColors;
            threeColors = newThreeColors;
        }

        return (int) ((twoColors + threeColors) % mod);
    }
}