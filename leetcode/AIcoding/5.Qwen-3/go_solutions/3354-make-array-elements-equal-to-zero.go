package main

func minOperations(ints []int, k int) int {
    ops := 0
    for true {
        hasOdd := false
        for i := 0; i < len(ints); i++ {
            if ints[i]%2 == 1 {
                hasOdd = true
                break
            }
        }
        if !hasOdd {
            break
        }
        for i := 0; i < len(ints); i++ {
            if ints[i]%2 == 1 {
                ints[i]--
                ops++
            }
        }
        for i := 0; i < len(ints); i++ {
            ints[i] /= 2
            ops++
        }
    }
    return ops
}