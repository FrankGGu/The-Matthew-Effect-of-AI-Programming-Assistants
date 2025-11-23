package main

func smallestDivisibleDigitProduct(n int) int {
    if n == 0 {
        return 0
    }
    for i := 1; ; i++ {
        product := 1
        for _, c := range strconv.Itoa(i) {
            digit := int(c - '0')
            product *= digit
            if product > n {
                break
            }
        }
        if product == n {
            return i
        }
    }
}