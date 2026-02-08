class Solution {
    public int accountBalanceAfterPurchase(int purchaseAmount) {
        int remainder = purchaseAmount % 10;
        int roundedAmount;
        if (remainder < 5) {
            roundedAmount = purchaseAmount - remainder;
        } else {
            roundedAmount = purchaseAmount + (10 - remainder);
        }
        return 100 - roundedAmount;
    }
}