func accountBalanceAfterPurchase(purchaseAmount int) int {
    remainder := purchaseAmount % 10
    if remainder < 5 {
        purchaseAmount -= remainder
    } else {
        purchaseAmount += (10 - remainder)
    }
    return 100 - purchaseAmount
}