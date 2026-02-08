func findMaximumNumber(K int64, x int) int64 {
    low, high := int64(0), int64(1e15)
    var res int64
    for low <= high {
        mid := (low + high) / 2
        sum := calculateSum(mid, x)
        if sum <= K {
            res = mid
            low = mid + 1
        } else {
            high = mid - 1
        }
    }
    return res
}

func calculateSum(num int64, x int) int64 {
    var sum int64
    for i := 0; (1 << i) <= num; i++ {
        if (i+1)%x == 0 {
            mask := int64(1 << i)
            fullBlocks := (num + 1) / (mask << 1)
            cnt := fullBlocks * mask
            remainder := (num + 1) % (mask << 1)
            cnt += max(0, remainder-mask)
            sum += cnt
        }
    }
    return sum
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}