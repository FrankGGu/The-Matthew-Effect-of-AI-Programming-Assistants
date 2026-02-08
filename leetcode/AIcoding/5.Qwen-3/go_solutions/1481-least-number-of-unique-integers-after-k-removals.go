package main

func findLeastNumOfUniqueInts(arr []int, k int) int {
    count := make(map[int]int)
    for _, num := range arr {
        count[num]++
    }

    counts := make([]int, 0, len(count))
    for _, v := range count {
        counts = append(counts, v)
    }

    sort.Ints(counts)

    for i := 0; i < len(counts) && k > 0; i++ {
        if counts[i] <= k {
            k -= counts[i]
            counts[i] = 0
        } else {
            break
        }
    }

    result := 0
    for _, v := range counts {
        if v > 0 {
            result++
        }
    }

    return result
}