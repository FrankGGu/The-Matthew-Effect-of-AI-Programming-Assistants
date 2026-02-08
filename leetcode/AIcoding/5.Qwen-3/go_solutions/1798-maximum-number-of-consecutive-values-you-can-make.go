package main

func main() {
}

func getMaximumConsecutive(nums []int) int {
    sort.Ints(nums)
    res := 1
    for i := 0; i < len(nums); i++ {
        if nums[i] < res {
            res += nums[i]
        }
    }
    return res
}