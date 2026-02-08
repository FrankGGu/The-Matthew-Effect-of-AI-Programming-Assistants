package main

func primeSubOperation(nums []int) int {
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    isPrime := make([]bool, maxNum+1)
    for i := range isPrime {
        isPrime[i] = true
    }
    isPrime[0], isPrime[1] = false, false
    for i := 2; i*i <= maxNum; i++ {
        if isPrime[i] {
            for j := i * i; j <= maxNum; j += i {
                isPrime[j] = false
            }
        }
    }

    for i := len(nums) - 1; i >= 0; i-- {
        for p := 2; p <= nums[i]-1; p++ {
            if isPrime[p] && nums[i]-p > 0 && (i == 0 || nums[i]-p < nums[i-1]) {
                nums[i] -= p
                break
            }
        }
    }

    return len(nums)
}