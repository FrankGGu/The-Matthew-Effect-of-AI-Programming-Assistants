package main

func countDifferentSubsequenceGCDs(nums []int) int {
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    seen := make(map[int]bool)
    for _, num := range nums {
        seen[num] = true
    }

    result := 0
    for i := 1; i <= maxNum; i++ {
        var currentGCD int
        for j := i; j <= maxNum; j += i {
            if seen[j] {
                if currentGCD == 0 {
                    currentGCD = j
                } else {
                    currentGCD = gcd(currentGCD, j)
                }
            }
        }
        if currentGCD == i {
            result++
        }
    }
    return result
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}