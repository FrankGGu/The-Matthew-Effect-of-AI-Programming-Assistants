package main

func optimalDivision(nums []int) string {
    if len(nums) <= 1 {
        return strconv.Itoa(nums[0])
    }
    if len(nums) == 2 {
        return strconv.Itoa(nums[0]) + "/" + strconv.Itoa(nums[1])
    }
    res := strconv.Itoa(nums[0]) + "/("
    for i := 1; i < len(nums)-1; i++ {
        res += strconv.Itoa(nums[i]) + "/"
    }
    res += strconv.Itoa(nums[len(nums)-1]) + ")"
    return res
}