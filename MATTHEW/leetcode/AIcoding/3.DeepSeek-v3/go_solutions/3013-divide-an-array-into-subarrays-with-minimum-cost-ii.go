func minimumCost(nums []int, k int, dist int) int64 {
    n := len(nums)
    if n == 0 {
        return 0
    }

    res := int64(1 << 60)
    for i := 1; i <= dist+1 && i < n; i++ {
        current := []int{}
        sum := int64(nums[0])
        current = append(current, nums[i])
        sum += int64(nums[i])
        last := i
        cnt := 2

        for j := i + 1; j < n && cnt < k; j++ {
            if j - last <= dist {
                current = append(current, nums[j])
                sum += int64(nums[j])
                last = j
                cnt++
            }
        }

        if cnt == k && sum < res {
            res = sum
        }
    }

    if res == int64(1 << 60) {
        return 0
    }
    return res
}