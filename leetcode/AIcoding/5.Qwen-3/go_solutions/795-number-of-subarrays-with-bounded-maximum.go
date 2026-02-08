package main

func numSubarrayBoundedMax(nums []int, left int, right int) int {
    res := 0
    last := -1
    prev := -1
    for i, num := range nums {
        if num >= left && num <= right {
            prev = i
        } else if num < left {
            prev = last
        } else {
            last = i
        }
        if prev != -1 {
            res += prev - last
        }
    }
    return res
}