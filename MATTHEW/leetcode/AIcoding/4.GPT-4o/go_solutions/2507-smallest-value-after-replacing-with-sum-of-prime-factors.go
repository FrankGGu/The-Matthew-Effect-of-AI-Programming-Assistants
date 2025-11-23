package main

import "math"

func smallestValue(n int) int {
    for {
        original := n
        sum := 0
        for i := 2; i <= int(math.Sqrt(float64(n))); i++ {
            for n%i == 0 {
                sum += i
                n /= i
            }
        }
        if n > 1 {
            sum += n
        }
        if sum == original {
            return sum
        }
        n = sum
    }
}