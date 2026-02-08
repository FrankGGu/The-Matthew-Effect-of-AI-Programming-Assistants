func arraySign(nums []int) int {
    product := 1
    for _, num := range nums {
        if num == 0 {
            return 0
        } else if num < 0 {
            product *= -1
        }
    }
    return product
}