func minOperations(num1 int, num2 int) int {
    if num1 == num2 {
        return 0
    }

    if num1 > num2 {
        num1, num2 = num2, num1
    }

    operations := 0
    for num1 < num2 {
        if num2%2 == 0 {
            num2 /= 2
        } else {
            num2++
        }
        operations++
    }

    return operations + (num1 - num2)
}