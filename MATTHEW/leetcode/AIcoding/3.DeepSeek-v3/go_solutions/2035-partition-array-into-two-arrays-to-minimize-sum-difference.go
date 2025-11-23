func minimumDifference(nums []int) int {
    n := len(nums) / 2
    total := 0
    for _, num := range nums {
        total += num
    }

    left := nums[:n]
    right := nums[n:]

    leftSums := make([][]int, n+1)
    rightSums := make([][]int, n+1)
    for i := 0; i <= n; i++ {
        leftSums[i] = make([]int, 0)
        rightSums[i] = make([]int, 0)
    }

    for mask := 0; mask < (1 << n); mask++ {
        cnt := bits.OnesCount(uint(mask))
        sum := 0
        for i := 0; i < n; i++ {
            if mask & (1 << i) != 0 {
                sum += left[i]
            }
        }
        leftSums[cnt] = append(leftSums[cnt], sum)
    }

    for mask := 0; mask < (1 << n); mask++ {
        cnt := bits.OnesCount(uint(mask))
        sum := 0
        for i := 0; i < n; i++ {
            if mask & (1 << i) != 0 {
                sum += right[i]
            }
        }
        rightSums[cnt] = append(rightSums[cnt], sum)
    }

    for k := 0; k <= n; k++ {
        sort.Ints(rightSums[k])
    }

    res := math.MaxInt32
    for k := 0; k <= n; k++ {
        l := k
        r := n - k
        if len(leftSums[l]) == 0 || len(rightSums[r]) == 0 {
            continue
        }
        for _, sumLeft := range leftSums[l] {
            target := (total - 2 * sumLeft) / 2
            idx := sort.SearchInts(rightSums[r], target)
            if idx < len(rightSums[r]) {
                sumRight := rightSums[r][idx]
                diff := abs(total - 2 * (sumLeft + sumRight))
                if diff < res {
                    res = diff
                }
            }
            if idx > 0 {
                sumRight := rightSums[r][idx-1]
                diff := abs(total - 2 * (sumLeft + sumRight))
                if diff < res {
                    res = diff
                }
            }
        }
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}