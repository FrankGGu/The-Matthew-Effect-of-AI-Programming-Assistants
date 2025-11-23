func findOriginalArray(changed []int) []int {
    if len(changed)%2 != 0 {
        return []int{}
    }

    freq := make(map[int]int)
    for _, num := range changed {
        freq[num]++
    }

    sort.Ints(changed)
    original := []int{}

    for _, num := range changed {
        if freq[num] == 0 {
            continue
        }
        doubled := num * 2
        if num == 0 {
            if freq[num] < 2 {
                return []int{}
            }
            freq[num] -= 2
            original = append(original, num)
        } else {
            if freq[doubled] == 0 {
                return []int{}
            }
            freq[num]--
            freq[doubled]--
            original = append(original, num)
        }
    }

    return original
}