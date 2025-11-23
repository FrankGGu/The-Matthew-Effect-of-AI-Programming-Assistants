int accountBalanceAfterPurchase(int purchaseAmount) {
    int remainder = purchaseAmount % 10;
    int roundedAmount;

    if (remainder >= 5) {
        roundedAmount = purchaseAmount - remainder + 10;
    } else {
        roundedAmount = purchaseAmount - remainder;
    }

    return 100 - roundedAmount;
}