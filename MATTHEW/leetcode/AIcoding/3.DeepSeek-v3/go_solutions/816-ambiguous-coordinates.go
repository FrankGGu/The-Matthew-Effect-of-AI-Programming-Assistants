func ambiguousCoordinates(s string) []string {
    s = s[1 : len(s)-1]
    var res []string
    for i := 1; i < len(s); i++ {
        left := s[:i]
        right := s[i:]
        leftNums := generateNumbers(left)
        rightNums := generateNumbers(right)
        for _, l := range leftNums {
            for _, r := range rightNums {
                res = append(res, "(" + l + ", " + r + ")")
            }
        }
    }
    return res
}

func generateNumbers(s string) []string {
    var nums []string
    if len(s) == 1 {
        return []string{s}
    }
    if s[0] == '0' {
        if s[len(s)-1] == '0' {
            return nums
        }
        nums = append(nums, "0." + s[1:])
        return nums
    }
    if s[len(s)-1] == '0' {
        return []string{s}
    }
    nums = append(nums, s)
    for i := 1; i < len(s); i++ {
        nums = append(nums, s[:i] + "." + s[i:])
    }
    return nums
}