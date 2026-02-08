func productOfBigArray(nums []int, queries [][]int) []int {
    mod := int(1e9) + 7
    res := make([]int, len(queries))
    for i, query := range queries {
        l, r, m := query[0], query[1], query[2]
        product := 1
        for j := l; j <= r; j++ {
            num := nums[j]
            for num > 0 {
                bit := num & -num
                product = (product * bit) % m
                num -= bit
            }
        }
        res[i] = product % m
    }
    return res
}