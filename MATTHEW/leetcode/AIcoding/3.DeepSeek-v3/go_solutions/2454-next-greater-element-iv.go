func secondGreaterElement(nums []int) []int {
    n := len(nums)
    res := make([]int, n)
    for i := range res {
        res[i] = -1
    }

    s1 := make([]int, 0)
    s2 := make([]int, 0)
    temp := make([]int, 0)

    for i := 0; i < n; i++ {
        for len(s2) > 0 && nums[s2[len(s2)-1]] < nums[i] {
            res[s2[len(s2)-1]] = nums[i]
            s2 = s2[:len(s2)-1]
        }

        for len(s1) > 0 && nums[s1[len(s1)-1]] < nums[i] {
            temp = append(temp, s1[len(s1)-1])
            s1 = s1[:len(s1)-1]
        }

        for len(temp) > 0 {
            s2 = append(s2, temp[len(temp)-1])
            temp = temp[:len(temp)-1]
        }

        s1 = append(s1, i)
    }

    return res
}