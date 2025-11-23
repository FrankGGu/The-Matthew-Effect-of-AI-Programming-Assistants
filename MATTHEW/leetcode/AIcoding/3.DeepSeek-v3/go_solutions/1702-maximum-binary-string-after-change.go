func maximumBinaryString(binary string) string {
    n := len(binary)
    zeros := 0
    firstZero := -1
    res := []byte(binary)

    for i := 0; i < n; i++ {
        if binary[i] == '0' {
            zeros++
            if firstZero == -1 {
                firstZero = i
            }
        }
    }

    if zeros <= 1 {
        return binary
    }

    for i := 0; i < n; i++ {
        if i == firstZero + zeros - 1 {
            res[i] = '0'
        } else {
            res[i] = '1'
        }
    }

    return string(res)
}