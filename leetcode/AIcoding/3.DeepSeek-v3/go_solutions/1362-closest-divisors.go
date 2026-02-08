func closestDivisors(num int) []int {
    res := []int{1, num + 1}
    for i := num + 1; i <= num+2; i++ {
        for j := int(math.Sqrt(float64(i))); j >= 1; j-- {
            if i%j == 0 {
                if abs(j-i/j) < abs(res[0]-res[1]) {
                    res[0], res[1] = j, i/j
                }
                break
            }
        }
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}