package main

func signFunc(x int) int {
    if x > 0 {
        return 1
    } else if x < 0 {
        return -1
    }
    return 0
}

func arraySign(nums []int) int {
    sign := 1
    for _, num := range nums {
        if num == 0 {
            return 0
        }
        sign *= signFunc(num)
    }
    return sign
}