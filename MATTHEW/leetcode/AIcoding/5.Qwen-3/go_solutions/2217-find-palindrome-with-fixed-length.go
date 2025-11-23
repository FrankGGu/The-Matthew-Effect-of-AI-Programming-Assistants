package main

func palindromeBuilder(n int) func() int {
    var num int
    if n == 1 {
        num = 0
    } else {
        num = 10
        for i := 1; i < n/2; i++ {
            num = num * 10 + 0
        }
    }
    return func() int {
        if n == 1 {
            num++
            return num
        }
        left := num
        right := num
        for i := 0; i < n/2; i++ {
            right = right / 10
        }
        if right == 0 {
            num++
            left = num
            right = num
            for i := 0; i < n/2; i++ {
                right = right / 10
            }
        }
        for i := 0; i < n/2; i++ {
            left = left * 10 + right%10
            right = right / 10
        }
        num++
        return left
    }
}

func kthPalindrome(arr []int, k int) []int {
    result := make([]int, len(arr))
    for i, n := range arr {
        builder := palindromeBuilder(n)
        for j := 0; j < k; j++ {
            result[i] = builder()
        }
    }
    return result
}