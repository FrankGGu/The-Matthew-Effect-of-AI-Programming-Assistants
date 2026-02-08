package main

func numberOfSubsequences(gcds []int, nums []int) int {
    maxGcd := 0
    for _, g := range gcds {
        if g > maxGcd {
            maxGcd = g
        }
    }

    count := make([]int, maxGcd+1)
    for _, num := range nums {
        for g := 1; g <= maxGcd; g++ {
            if num%g == 0 {
                count[g] += count[g]
                if num/g == 1 {
                    count[g]++
                } else {
                    count[g] += count[num/g]
                }
            }
        }
    }

    result := 0
    for _, g := range gcds {
        result += count[g]
    }

    return result
}