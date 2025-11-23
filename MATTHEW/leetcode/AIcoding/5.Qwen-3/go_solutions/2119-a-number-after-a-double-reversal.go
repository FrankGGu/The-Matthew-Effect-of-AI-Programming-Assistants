package main

func reverseNumber(n int) int {
    reversed := 0
    for n > 0 {
        reversed = reversed*10 + n%10
        n /= 10
    }
    return reversed
}

func isNumberAfterDoubleReversal(n int) bool {
    reversed1 := reverseNumber(n)
    reversed2 := reverseNumber(reversed1)
    return reversed2 == n
}