var accountBalanceAfterPurchase = function(purchaseAmount) {
    const rounded = Math.round(purchaseAmount / 10) * 10;
    return 100 - rounded;
};