class Solution {
    public int maxSpending(int[] prices, int budget) {
        Arrays.sort(prices);
        int totalSpent = 0, itemsBought = 0;

        for (int price : prices) {
            if (totalSpent + price <= budget) {
                totalSpent += price;
                itemsBought++;
            } else {
                break;
            }
        }

        return totalSpent;
    }
}