func sortEvenOdd(nums []int) []int {
    var evens, odds []int
    for i, num := range nums {
        if i%2 == 0 {
            evens = append(evens, num)
        } else {
            odds = append(odds, num)
        }
    }
    sort.Ints(evens)
    sort.Slice(odds, func(i, j int) bool {
        return odds[i] > odds[j]
    })
    result := make([]int, len(nums))
    e, o := 0, 0
    for i := range result {
        if i%2 == 0 {
            result[i] = evens[e]
            e++
        } else {
            result[i] = odds[o]
            o++
        }
    }
    return result
}