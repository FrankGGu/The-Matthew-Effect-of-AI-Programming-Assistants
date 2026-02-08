func prefixesDivBy5(nums []int) []bool {
    result := make([]bool, len(nums))
    num := 0
    for i, v := range nums {
        num = (num << 1 | v) % 5
        result[i] = num == 0
    }
    return result
}