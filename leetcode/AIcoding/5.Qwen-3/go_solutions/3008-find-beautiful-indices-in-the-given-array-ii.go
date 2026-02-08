package main

func beautifulIndices(nums []int, s string, k int) []int {
    n := len(nums)
    res := make([]int, 0)
    for i := 0; i < n; i++ {
        if isBeautiful(nums[i], s, k) {
            res = append(res, i)
        }
    }
    return res
}

func isBeautiful(num int, s string, k int) bool {
    sNum := strconv.Itoa(num)
    m := len(sNum)
    for i := 0; i <= len(s)-m; i++ {
        if s[i:i+m] == sNum {
            return true
        }
    }
    return false
}