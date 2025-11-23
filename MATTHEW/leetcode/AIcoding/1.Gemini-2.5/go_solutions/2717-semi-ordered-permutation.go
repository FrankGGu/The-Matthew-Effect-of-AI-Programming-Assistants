func semiOrderedPermutation(nums []int) int {
    n := len(nums)
    pos1 := -1
    posN := -1

    for i := 0; i < n; i++ {
        if nums[i] == 1 {
            pos1 = i
        }
        if nums[i] == n {
            posN = i
        }
    }

    swaps := pos1 + (n - 1 - posN)

    if pos1 > posN {
        swaps--
    }

    return swaps
}