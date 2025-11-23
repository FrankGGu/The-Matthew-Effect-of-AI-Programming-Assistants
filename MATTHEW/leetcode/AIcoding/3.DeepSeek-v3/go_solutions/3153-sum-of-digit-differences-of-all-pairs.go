func sumDigitDifferences(nums []int) int64 {
    n := len(nums)
    if n == 0 {
        return 0
    }
    s := strconv.Itoa(nums[0])
    m := len(s)
    count := make([][10]int, m)
    for _, num := range nums {
        s := strconv.Itoa(num)
        for i := 0; i < m; i++ {
            digit := int(s[i] - '0')
            count[i][digit]++
        }
    }
    var res int64
    for i := 0; i < m; i++ {
        for d1 := 0; d1 < 10; d1++ {
            for d2 := d1 + 1; d2 < 10; d2++ {
                res += int64(count[i][d1] * count[i][d2])
            }
        }
    }
    return res
}