package main

func concatenationValue(nums []int) int {
    left := 0
    right := len(nums) - 1
    result := 0

    for left <= right {
        if left == right {
            result += nums[left]
        } else {
            result += nums[left] * pow(10, len(strconv.Itoa(nums[right])))
            result += nums[right]
        }
        left++
        right--
    }

    return result
}

func pow(a, b int) int {
    res := 1
    for i := 0; i < b; i++ {
        res *= a
    }
    return res
}