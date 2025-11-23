func rearrangeBarcodes(barcodes []int) []int {
    count := make(map[int]int)
    for _, barcode := range barcodes {
        count[barcode]++
    }

    type pair struct {
        barcode int
        freq    int
    }

    pairs := make([]pair, 0, len(count))
    for k, v := range count {
        pairs = append(pairs, pair{barcode: k, freq: v})
    }

    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i].freq > pairs[j].freq
    })

    result := make([]int, len(barcodes))
    index := 0
    for _, p := range pairs {
        for p.freq > 0 {
            if index >= len(barcodes) {
                index = 1
            }
            result[index] = p.barcode
            index += 2
            p.freq--
        }
    }

    return result
}