func maxEqualFreq(nums []int) int {
    count := make(map[int]int)
    freq := make(map[int]int)
    maxFreq := 0
    result := 0

    for i, num := range nums {
        if count[num] > 0 {
            freq[count[num]]--
            if freq[count[num]] == 0 {
                delete(freq, count[num])
            }
        }
        count[num]++
        freq[count[num]]++
        maxFreq = max(maxFreq, count[num])

        if len(freq) == 1 {
            for k := range freq {
                if k == 1 || freq[k] == 1 {
                    result = i + 1
                }
            }
        } else if len(freq) == 2 {
            keys := []int{}
            for k := range freq {
                keys = append(keys, k)
            }
            if (keys[0] == 1 && freq[keys[0]] == 1) || (keys[1] == 1 && freq[keys[1]] == 1) || (abs(keys[0]-keys[1]) == 1 && (freq[keys[0]] == 1 || freq[keys[1]] == 1)) {
                result = i + 1
            }
        }
    }
    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}