package main

func distinctPrimeFactors(nums []int) int {
    primeSet := make(map[int]bool)
    for _, num := range nums {
        i := 2
        for i*i <= num {
            if num%i == 0 {
                primeSet[i] = true
                for num%i == 0 {
                    num /= i
                }
            }
            i++
        }
        if num > 1 {
            primeSet[num] = true
        }
    }
    return len(primeSet)
}