class Solution {
    public int buyChoco(int[] prices, int money) {
        Arrays.sort(prices);
        int totalCost = prices[0] + prices[1];
        return money >= totalCost ? money - totalCost : money;
    }
}