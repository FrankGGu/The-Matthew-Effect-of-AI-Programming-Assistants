func maximumDistinctElements(nums []int, k int) int {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }

    distinct := 0
    duplicates := make([]int, 0)

    for num, count := range freq {
        if count == 1 {
            distinct++
        } else {
            duplicates = append(duplicates, count)
        }
    }

    sort.Ints(duplicates)

    for _, count := range duplicates {
        needed := count - 1
        if k >= needed {
            k -= needed
            distinct++
        } else {
            return distinct + k
        }
    }

    return distinct - k
}