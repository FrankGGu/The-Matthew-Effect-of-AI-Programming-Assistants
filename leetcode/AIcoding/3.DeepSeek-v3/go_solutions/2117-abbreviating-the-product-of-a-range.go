func abbreviateProduct(left int, right int) string {
    product := big.NewInt(1)
    for i := left; i <= right; i++ {
        product.Mul(product, big.NewInt(int64(i)))
    }

    str := product.String()
    n := len(str)
    if n <= 10 {
        return str
    }

    firstFive := str[:5]
    lastFive := str[n-5:]
    nonZero := 0
    for i := n - 1; i >= 0; i-- {
        if str[i] != '0' {
            nonZero = i
            break
        }
    }
    trailingZeros := n - 1 - nonZero

    return firstFive + "..." + lastFive + "e" + strconv.Itoa(trailingZeros)
}