func countSubarrays(nums []int, k int) int {
    pos := 0
    for nums[pos] != k {
        pos++
    }

    count := make(map[int]int)
    count[0] = 1
    balance := 0
    res := 0

    for i := pos + 1; i < len(nums); i++ {
        if nums[i] > k {
            balance++
        } else {
            balance--
        }
        count[balance]++
    }

    res += count[0] + count[1]

    balance = 0
    for i := pos - 1; i >= 0; i-- {
        if nums[i] > k {
            balance++
        } else {
            balance--
        }
        res += count[-balance] + count[1-balance]
    }

    return res
}