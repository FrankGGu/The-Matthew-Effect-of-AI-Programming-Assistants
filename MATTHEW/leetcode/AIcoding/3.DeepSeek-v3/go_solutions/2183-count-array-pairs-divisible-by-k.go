func countPairs(nums []int, k int) int64 {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[gcd(num, k)]++
    }

    var res int64
    for a, cntA := range freq {
        for b, cntB := range freq {
            if a > b {
                continue
            }
            if (a * b) % k == 0 {
                if a == b {
                    res += int64(cntA * (cntA - 1) / 2)
                } else {
                    res += int64(cntA * cntB)
                }
            }
        }
    }
    return res
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a % b
    }
    return a
}