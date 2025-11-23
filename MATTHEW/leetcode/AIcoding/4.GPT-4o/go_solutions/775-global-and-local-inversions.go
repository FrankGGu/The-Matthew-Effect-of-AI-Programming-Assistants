package main

func isIdealPermutation(A []int) bool {
    for i, a := range A {
        if a > i + 1 {
            return false
        }
    }
    return true
}