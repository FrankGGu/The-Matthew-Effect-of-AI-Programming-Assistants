package main

func rearrangeBarcodes(barcodes []int) []int {
    if len(barcodes) <= 1 {
        return barcodes
    }

    count := make(map[int]int)
    for _, b := range barcodes {
        count[b]++
    }

    type pair struct {
        val, freq int
    }

    var pairs []pair
    for k, v := range count {
        pairs = append(pairs, pair{k, v})
    }

    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i].freq > pairs[j].freq
    })

    result := make([]int, len(barcodes))
    idx := 0

    for _, p := range pairs {
        for i := 0; i < p.freq; i++ {
            result[idx] = p.val
            idx += 2
            if idx >= len(barcodes) {
                idx = 1
            }
        }
    }

    return result
}