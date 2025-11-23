func movesToMakeZigzag(nums []int) int {
    n := len(nums)
    ans1 := 0
    ans2 := 0

    temp1 := make([]int, n)
    copy(temp1, nums)
    temp2 := make([]int, n)
    copy(temp2, nums)

    for i := 0; i < n; i++ {
        if i%2 == 0 {
            if i > 0 && temp1[i] >= temp1[i-1] {
                ans1 += temp1[i] - temp1[i-1] + 1
                temp1[i] = temp1[i-1] - 1
            }
            if i < n-1 && temp1[i] >= temp1[i+1] {
                ans1 += temp1[i] - temp1[i+1] + 1
                temp1[i] = temp1[i+1] - 1
            }
        } else {
            if i > 0 && temp2[i] >= temp2[i-1] {
                ans2 += temp2[i] - temp2[i-1] + 1
                temp2[i] = temp2[i-1] - 1
            }
            if i < n-1 && temp2[i] >= temp2[i+1] {
                ans2 += temp2[i] - temp2[i+1] + 1
                temp2[i] = temp2[i+1] - 1
            }
        }
    }

    if ans1 < ans2 {
        return ans1
    }
    return ans2
}