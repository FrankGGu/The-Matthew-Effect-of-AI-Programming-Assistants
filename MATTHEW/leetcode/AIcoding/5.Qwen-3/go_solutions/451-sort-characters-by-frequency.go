package main

func frequencySort(s string) string {
    freq := make(map[rune]int)
    for _, c := range s {
        freq[c]++
    }

    buckets := make([][]rune, len(s)+1)
    for c, count := range freq {
        buckets[count] = append(buckets[count], c)
    }

    result := make([]rune, 0, len(s))
    for i := len(buckets) - 1; i > 0; i-- {
        for _, c := range buckets[i] {
            for j := 0; j < i; j++ {
                result = append(result, c)
            }
        }
    }

    return string(result)
}