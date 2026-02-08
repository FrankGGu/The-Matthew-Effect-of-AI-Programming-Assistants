func pickGifts(gifts []int, k int) int {
    sort.Sort(sort.Reverse(sort.IntSlice(gifts)))
    for i := 0; i < k; i++ {
        if gifts[0] == 0 {
            break
        }
        gifts[0] = int(math.Sqrt(float64(gifts[0])))
        sort.Sort(sort.Reverse(sort.IntSlice(gifts)))
    }
    total := 0
    for _, gift := range gifts {
        total += gift
    }
    return total
}