func minSubarray(nums []int, p int) int {
    total := 0
    for _, num := range nums {
        total = (total + num) % p
    }
    if total == 0 {
        return 0
    }

    res := len(nums)
    prefix := 0
    last := make(map[int]int)
    last[0] = -1

    for i, num := range nums {
        prefix = (prefix + num) % p
        target := (prefix - total + p) % p
        if pos, exists := last[target]; exists {
            if i - pos < res {
                res = i - pos
            }
        }
        last[prefix] = i
    }

    if res >= len(nums) {
        return -1
    }
    return res
}