func minDifference(nums []int, queries [][]int) []int {
    n := len(nums)
    prefix := make([][101]int, n+1)

    for i := 1; i <= n; i++ {
        for j := 1; j <= 100; j++ {
            prefix[i][j] = prefix[i-1][j]
        }
        prefix[i][nums[i-1]]++
    }

    res := make([]int, len(queries))
    for k, q := range queries {
        l, r := q[0], q[1]
        prev := -1
        minDiff := math.MaxInt32
        for j := 1; j <= 100; j++ {
            if prefix[r+1][j] - prefix[l][j] > 0 {
                if prev != -1 {
                    diff := j - prev
                    if diff < minDiff {
                        minDiff = diff
                    }
                }
                prev = j
            }
        }
        if minDiff == math.MaxInt32 {
            res[k] = -1
        } else {
            res[k] = minDiff
        }
    }
    return res
}