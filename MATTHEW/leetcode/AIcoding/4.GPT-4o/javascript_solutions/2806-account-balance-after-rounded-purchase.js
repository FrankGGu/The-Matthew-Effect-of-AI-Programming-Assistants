function accountBalanceAfterPurchase(purchaseAmount) {
    const balance = 1000;
    const roundedPurchase = Math.round(purchaseAmount / 10) * 10;
    return balance - roundedPurchase;
}