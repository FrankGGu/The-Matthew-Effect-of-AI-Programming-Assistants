func canChoose(groups [][]int, nums []int) bool {
    n := len(nums)
    i := 0
    for _, group := range groups {
        found := false
        gl := len(group)
        for i+gl <= n {
            match := true
            for j := 0; j < gl; j++ {
                if nums[i+j] != group[j] {
                    match = false
                    break
                }
            }
            if match {
                i += gl
                found = true
                break
            } else {
                i++
            }
        }
        if !found {
            return false
        }
    }
    return true
}