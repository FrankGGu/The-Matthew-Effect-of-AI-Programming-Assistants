class Solution {
public:
    int accountBalanceAfterPurchase(int purchaseAmount) {
        int roundedAmount = (purchaseAmount + 9) / 10 * 10;
        return 100 - roundedAmount;
    }
};