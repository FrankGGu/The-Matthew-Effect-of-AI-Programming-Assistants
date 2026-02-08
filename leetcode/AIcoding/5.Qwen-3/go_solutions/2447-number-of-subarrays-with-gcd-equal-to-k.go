package main

func numberOfSubarrays(nums []int, k int) int {
    count := 0
    for i := 0; i < len(nums); i++ {
        currentGCD := nums[i]
        if currentGCD == k {
            count++
        }
        for j := i + 1; j < len(nums); j++ {
            currentGCD = gcd(currentGCD, nums[j])
            if currentGCD == k {
                count++
            }
        }
    }
    return count
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}