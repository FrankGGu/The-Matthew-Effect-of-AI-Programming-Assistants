package main

func findComplement(num int) int {
    mask := 1
    for num&mask != 0 {
        mask <<= 1
    }
    return num ^ (mask - 1)
}