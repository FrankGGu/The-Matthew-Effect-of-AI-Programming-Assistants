func isPalindrome(x int) bool {
    if x < 0 {
        return false
    }
    if x < 10 {
        return true
    }
    if x%10 == 0 {
        return false
    }

    reversedNum := 0
    for x > reversedNum {
        reversedNum = reversedNum*10 + x%10
        x /= 10
    }

    return x == reversedNum || x == reversedNum/10
}