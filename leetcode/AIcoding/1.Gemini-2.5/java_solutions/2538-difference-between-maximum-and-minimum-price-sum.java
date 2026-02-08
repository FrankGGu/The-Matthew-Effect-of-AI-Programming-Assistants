import java.util.Arrays;

class Solution {
    public long maxPriceSum(int[] prices, int[][] edges) {
        long maxPrice = Long.MIN_VALUE;
        long minPrice = Long.MAX_VALUE;

        for (int price : prices) {
            maxPrice = Math.max(maxPrice, price);
            minPrice = Math.min(minPrice, price);
        }

        return maxPrice - minPrice;
    }
}