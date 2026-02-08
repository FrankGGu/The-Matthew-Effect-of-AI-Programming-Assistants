package main

func smallestRepunitDivisible(a int) int {
    if a%2 == 0 || a%5 == 0 {
        return -1
    }
    mod := 1 % a
    for i := 1; mod != 0; i++ {
        mod = (mod * 10 + 1) % a
    }
    return i
}