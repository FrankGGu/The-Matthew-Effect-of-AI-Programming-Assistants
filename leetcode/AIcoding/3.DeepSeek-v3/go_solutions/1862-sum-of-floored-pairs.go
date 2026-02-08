func sumOfFlooredPairs(nums []int) int {
    const mod = 1e9 + 7
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    freq := make([]int, maxNum + 1)
    prefix := make([]int, maxNum + 1)
    for _, num := range nums {
        freq[num]++
    }

    for i := 1; i <= maxNum; i++ {
        prefix[i] = prefix[i-1] + freq[i]
    }

    res := 0
    for y := 1; y <= maxNum; y++ {
        if freq[y] == 0 {
            continue
        }
        for d := 1; d * y <= maxNum; d++ {
            lower := d * y
            upper := (d + 1) * y - 1
            if upper > maxNum {
                upper = maxNum
            }
            cnt := prefix[upper] - prefix[lower-1]
            res = (res + cnt * d * freq[y]) % mod
        }
    }
    return res
}