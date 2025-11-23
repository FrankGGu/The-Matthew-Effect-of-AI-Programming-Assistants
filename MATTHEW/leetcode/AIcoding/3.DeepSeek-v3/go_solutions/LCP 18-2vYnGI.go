func breakfastNumber(staple []int, drinks []int, x int) int {
    const mod = 1e9 + 7
    sort.Ints(staple)
    sort.Ints(drinks)
    res := 0
    j := len(drinks) - 1
    for i := 0; i < len(staple); i++ {
        for j >= 0 && staple[i] + drinks[j] > x {
            j--
        }
        res += j + 1
        res %= mod
    }
    return res
}