func powerfulIntegers(x int, y int, bound int) []int {
    res := make(map[int]bool)
    for a := 1; a < bound; a *= x {
        for b := 1; a + b <= bound; b *= y {
            res[a + b] = true
            if y == 1 {
                break
            }
        }
        if x == 1 {
            break
        }
    }
    ans := make([]int, 0, len(res))
    for k := range res {
        ans = append(ans, k)
    }
    return ans
}