class Solution {
    public int arrangeCoins(int n) {
        long num = (long) n;
        long k = (long) ((-1 + Math.sqrt(1 + 8 * num)) / 2);
        return (int) k;
    }
}