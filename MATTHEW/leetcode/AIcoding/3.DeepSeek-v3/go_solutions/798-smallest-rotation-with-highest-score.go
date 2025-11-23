func bestRotation(nums []int) int {
    n := len(nums)
    diff := make([]int, n+1)
    for i := 0; i < n; i++ {
        a := (i - nums[i] + 1 + n) % n
        b := (i + 1) % n
        if a <= b {
            diff[a]++
            diff[b]--
        } else {
            diff[a]++
            diff[0]++
            diff[b]--
        }
    }
    maxScore := 0
    res := 0
    score := 0
    for i := 0; i < n; i++ {
        score += diff[i]
        if score > maxScore {
            maxScore = score
            res = i
        }
    }
    return res
}