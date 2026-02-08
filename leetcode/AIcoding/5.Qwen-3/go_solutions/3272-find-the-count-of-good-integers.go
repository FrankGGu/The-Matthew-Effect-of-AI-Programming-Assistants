package main

func countGoodIntegers(n int) int {
    count := 0
    for i := 1; i <= n; i++ {
        s := strconv.Itoa(i)
        sum := 0
        for _, ch := range s {
            digit := int(ch - '0')
            sum += digit
        }
        if sum%3 == 0 {
            count++
        }
    }
    return count
}