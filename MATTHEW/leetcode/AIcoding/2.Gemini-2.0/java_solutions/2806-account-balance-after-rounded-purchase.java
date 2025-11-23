class Solution {
    public int accountBalanceAfterPurchase(int purchaseAmount) {
        int roundedAmount = (int) Math.round((double) purchaseAmount / 10) * 10;
        return 100 - roundedAmount;
    }
}