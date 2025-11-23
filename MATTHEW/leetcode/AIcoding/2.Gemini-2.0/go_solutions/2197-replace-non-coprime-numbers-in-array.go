func replaceNonCoprime(nums []int) []int {
    var res []int
    for _, num := range nums {
        for len(res) > 0 {
            g := gcd(res[len(res)-1], num)
            if g == 1 {
                break
            }
            num = lcm(res[len(res)-1], num)
            res = res[:len(res)-1]
        }
        res = append(res, num)
    }
    return res
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}

func lcm(a, b int) int {
    return a * b / gcd(a, b)
}