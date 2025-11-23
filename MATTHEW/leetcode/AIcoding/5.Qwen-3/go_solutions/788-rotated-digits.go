package main

func rotatedDigits(n int) int {
    count := 0
    for i := 1; i <= n; i++ {
        if isValid(i) {
            count++
        }
    }
    return count
}

func isValid(num int) bool {
    invalid := map[byte]bool{'2': true, '3': true, '5': true, '7': true, '4': true, '1': true, '0': true}
    valid := map[byte]bool{'6': true, '9': true}
    hasValid := false
    for num > 0 {
        digit := byte(num % 10)
        if invalid[digit] {
            return false
        }
        if valid[digit] {
            hasValid = true
        }
        num /= 10
    }
    return hasValid
}