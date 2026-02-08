package main

func numSubarrayLCM(ints []int, k int) int {
    n := len(ints)
    count := 0
    for i := 0; i < n; i++ {
        currentLCM := ints[i]
        if currentLCM == k {
            count++
        }
        for j := i + 1; j < n; j++ {
            currentLCM = lcm(currentLCM, ints[j])
            if currentLCM == k {
                count++
            } else if currentLCM > k {
                break
            }
        }
    }
    return count
}

func lcm(a, b int) int {
    return a * b / gcd(a, b)
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}