package main

func sumOfNumberAndReverse(num int) int {
    return num + reverse(num)
}

func reverse(n int) int {
    rev := 0
    for n > 0 {
        rev = rev*10 + n%10
        n /= 10
    }
    return rev
}