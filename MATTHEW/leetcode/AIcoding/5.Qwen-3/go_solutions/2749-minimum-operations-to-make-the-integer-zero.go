package main

func minimumOperations(num string) int {
    n := len(num)
    for i := n - 1; i >= 0; i-- {
        if num[i] == '0' {
            return n - i - 1
        }
    }
    return n
}