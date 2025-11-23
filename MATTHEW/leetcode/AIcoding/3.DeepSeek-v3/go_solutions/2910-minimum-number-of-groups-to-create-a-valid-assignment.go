func minGroupsForValidAssignment(nums []int) int {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }

    counts := make([]int, 0, len(freq))
    for _, v := range freq {
        counts = append(counts, v)
    }

    minCount := counts[0]
    for _, cnt := range counts {
        if cnt < minCount {
            minCount = cnt
        }
    }

    for k := minCount; k >= 1; k-- {
        total := 0
        valid := true
        for _, cnt := range counts {
            q := cnt / (k + 1)
            r := cnt % (k + 1)
            if r == 0 {
                total += q
            } else if k - r <= q {
                total += q + 1
            } else {
                valid = false
                break
            }
        }
        if valid {
            return total
        }
    }
    return -1
}