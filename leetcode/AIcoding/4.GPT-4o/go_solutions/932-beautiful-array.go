func beautifulArray(n int) []int {
    ans := make([]int, 0, n)
    var helper func(int)
    helper = func(x int) {
        if x == 0 {
            return
        }
        if x == 1 {
            ans = append(ans, 1)
            return
        }
        for _, i := range []int{1, 2} {
            for j := 1; j <= x; j++ {
                if (j+i)%2 == 1 {
                    ans = append(ans, j)
                }
            }
            helper((x + 1) / 2)
            ans = ans[:0]
        }
    }
    helper(n)
    return ans
}