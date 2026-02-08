func abbreviateProduct(left int, right int) string {
    if left > right {
        return ""
    }

    product := 1
    for i := left; i <= right; i++ {
        product *= i
        for product % 10 == 0 {
            product /= 10
        }
        if product >= 1e10 {
            product %= 1e10
        }
    }

    result := fmt.Sprintf("%d", product)
    if len(result) > 10 {
        return fmt.Sprintf("%s...%s", result[:5], result[len(result)-5:])
    }

    return result
}