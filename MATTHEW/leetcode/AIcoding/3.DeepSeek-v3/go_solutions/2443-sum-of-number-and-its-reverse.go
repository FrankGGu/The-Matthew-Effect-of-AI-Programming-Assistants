func sumOfNumberAndReverse(num int) bool {
    for i := 0; i <= num; i++ {
        reversed := 0
        n := i
        for n > 0 {
            reversed = reversed*10 + n%10
            n /= 10
        }
        if i + reversed == num {
            return true
        }
    }
    return false
}