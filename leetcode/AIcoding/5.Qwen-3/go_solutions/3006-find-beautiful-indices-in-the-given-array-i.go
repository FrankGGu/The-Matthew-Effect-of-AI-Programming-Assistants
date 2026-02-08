package main

func beautifulIndices(nums []int, s string) []int {
    n := len(nums)
    m := len(s)
    res := make([]int, 0)
    for i := 0; i < n; i++ {
        if i > 0 && nums[i] == nums[i-1] {
            continue
        }
        found := false
        for j := 0; j <= m-len(s); j++ {
            match := true
            for k := 0; k < len(s); k++ {
                if nums[i+k] != int(s[k]) {
                    match = false
                    break
                }
            }
            if match {
                found = true
                break
            }
        }
        if found {
            res = append(res, i)
        }
    }
    return res
}