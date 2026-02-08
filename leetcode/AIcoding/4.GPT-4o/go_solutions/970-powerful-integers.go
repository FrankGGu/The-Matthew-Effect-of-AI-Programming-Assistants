func powerfulIntegers(x int, y int, bound int) []int {
    result := make(map[int]struct{})
    for i := 0; ; i++ {
        powX := int(math.Pow(float64(x), float64(i)))
        if powX >= bound {
            break
        }
        for j := 0; ; j++ {
            powY := int(math.Pow(float64(y), float64(j)))
            sum := powX + powY
            if sum >= bound {
                break
            }
            result[sum] = struct{}{}
            if y == 1 {
                break
            }
            j++
        }
        if x == 1 {
            break
        }
        i++
    }
    ans := make([]int, 0, len(result))
    for k := range result {
        ans = append(ans, k)
    }
    sort.Ints(ans)
    return ans
}