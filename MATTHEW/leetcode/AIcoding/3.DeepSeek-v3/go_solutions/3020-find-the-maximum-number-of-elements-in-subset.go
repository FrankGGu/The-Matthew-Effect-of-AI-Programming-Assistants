func maximumLength(nums []int) int {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }

    maxLen := 1
    if freq[1] > 0 {
        maxLen = freq[1] | 1
    }

    for num := range freq {
        if num == 1 {
            continue
        }
        current := num
        length := 0
        for {
            if cnt, exists := freq[current]; exists && cnt >= 2 {
                length += 2
                next := current * current
                if next > current && next <= 1e9 {
                    current = next
                } else {
                    break
                }
            } else {
                if exists && cnt == 1 {
                    length += 1
                } else {
                    length -= 1
                }
                break
            }
        }
        if length > maxLen {
            maxLen = length
        }
    }

    return maxLen
}