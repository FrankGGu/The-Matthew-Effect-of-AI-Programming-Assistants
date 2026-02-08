public class Solution {
    public int accountBalanceAfterRoundedPurchase(int purchaseAmount) {
        int rounded = (purchaseAmount + 5) / 10 * 10;
        return 200 - rounded;
    }
}