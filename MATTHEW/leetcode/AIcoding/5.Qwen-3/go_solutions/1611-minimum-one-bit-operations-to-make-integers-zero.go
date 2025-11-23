package main

func minimumOneBitOperations(target int) int {
    if target == 0 {
        return 0
    }
    return (1 << bits.Len(uint(target))) - 1 - minimumOneBitOperations(target^(1 << bits.Len(uint(target))-1))
}