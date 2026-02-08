package main

func largestNumber(nums []int) string {
    sort.Slice(nums, func(i, j int) bool {
        a := strconv.Itoa(nums[i])
        b := strconv.Itoa(nums[j])
        return a+b > b+a
    })
    if nums[0] == 0 {
        return "0"
    }
    res := ""
    for _, num := range nums {
        res += strconv.Itoa(num)
    }
    return res
}