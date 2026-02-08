func findLeastNumOfUniqueInts(arr []int, k int) int {
    freq := make(map[int]int)
    for _, num := range arr {
        freq[num]++
    }

    counts := make([]int, 0, len(freq))
    for _, v := range freq {
        counts = append(counts, v)
    }

    sort.Ints(counts)

    res := len(counts)
    for _, cnt := range counts {
        if k >= cnt {
            k -= cnt
            res--
        } else {
            break
        }
    }

    return res
}