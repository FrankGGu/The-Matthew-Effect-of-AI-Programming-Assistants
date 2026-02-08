func waysToPartition(nums []int, k int) int {
    n := len(nums)
    prefix := make([]int, n)
    prefix[0] = nums[0]
    for i := 1; i < n; i++ {
        prefix[i] = prefix[i-1] + nums[i]
    }

    total := prefix[n-1]
    res := 0

    if total%2 == 0 {
        target := total / 2
        count := 0
        for i := 0; i < n-1; i++ {
            if prefix[i] == target {
                count++
            }
        }
        res = count
    }

    left := make(map[int]int)
    right := make(map[int]int)

    for i := 0; i < n-1; i++ {
        right[prefix[i]]++
    }

    for i := 0; i < n; i++ {
        newTotal := total - nums[i] + k
        if newTotal%2 == 0 {
            target := newTotal / 2
            temp := 0
            if val, ok := left[target]; ok {
                temp += val
            }
            newTarget := target - (k - nums[i])
            if val, ok := right[newTarget]; ok {
                temp += val
            }
            if temp > res {
                res = temp
            }
        }
        if i < n-1 {
            right[prefix[i]]--
            left[prefix[i]]++
        }
    }

    return res
}