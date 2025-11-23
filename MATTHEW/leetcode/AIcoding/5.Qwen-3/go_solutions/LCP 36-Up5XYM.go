package main

func maxNumberOfGroups(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    sort.Ints(nums)
    res := 0
    for i := 0; i < len(nums); i++ {
        if count[nums[i]] > 0 {
            res++
            for j := nums[i]; j <= nums[i]+2; j++ {
                count[j]--
            }
        }
    }
    return res
}