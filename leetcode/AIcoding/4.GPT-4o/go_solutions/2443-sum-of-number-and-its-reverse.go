func sumOfNumberAndReverse(num int) bool {
    reverse := func(n int) int {
        rev := 0
        for n > 0 {
            rev = rev*10 + n%10
            n /= 10
        }
        return rev
    }

    for i := 0; i <= num; i++ {
        if i + reverse(i) == num {
            return true
        }
    }
    return false
}