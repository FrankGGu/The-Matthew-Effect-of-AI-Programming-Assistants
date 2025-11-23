class Solution {
public:
    int accountBalanceAfterPurchase(int purchaseAmount) {
        int remainder = purchaseAmount % 10;
        int roundedAmount;
        if (remainder < 5) {
            roundedAmount = purchaseAmount - remainder;
        } else {
            roundedAmount = purchaseAmount - remainder + 10;
        }
        return 100 - roundedAmount;
    }
};