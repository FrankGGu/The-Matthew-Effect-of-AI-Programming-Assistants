package main

import "fmt"
import "math"

func findGCD(nums []int) int {
    minNum := math.MaxInt32
    maxNum := 0

    for _, num := range nums {
        if num < minNum {
            minNum = num
        }
        if num > maxNum {
            maxNum = num
        }
    }

    return gcd(maxNum, minNum)
}

func gcd(a, b int) int {
    if b == 0 {
        return a
    }
    return gcd(b, a%b)
}

func main() {
    nums := []int{2, 4, 6, 8, 10}
    fmt.Println(findGCD(nums))
}