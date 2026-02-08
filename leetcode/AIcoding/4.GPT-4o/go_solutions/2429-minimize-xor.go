func minimizeXor(num1 int, num2 int) int {
    count := 0
    for num2 > 0 {
        count += num2 & 1
        num2 >>= 1
    }

    result := 0
    for i := 31; i >= 0; i-- {
        if (num1>>i)&1 == 1 {
            if count > 0 {
                result |= (1 << i)
                count--
            }
        } else if count > 0 {
            result |= (1 << i)
            count--
        }
    }

    return result
}