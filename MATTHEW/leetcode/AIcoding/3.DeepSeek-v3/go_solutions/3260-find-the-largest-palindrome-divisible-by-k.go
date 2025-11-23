func largestPalindrome(k int) int {
    if k == 1 {
        return 9
    }
    upper := int(math.Pow10(k)) - 1
    lower := int(math.Pow10(k-1))
    maxNum := upper * upper
    firstHalf := maxNum / int(math.Pow10(k))

    for {
        candidate := createPalindrome(firstHalf)
        if candidate > maxNum {
            firstHalf--
            candidate = createPalindrome(firstHalf)
            if candidate > maxNum {
                continue
            }
        }
        for i := upper; i >= lower; i-- {
            if candidate/i > upper {
                break
            }
            if candidate%i == 0 {
                return candidate % 1337
            }
        }
        firstHalf--
    }
}

func createPalindrome(firstHalf int) int {
    s := strconv.Itoa(firstHalf)
    bytes := []byte(s)
    for i := 0; i < len(bytes)/2; i++ {
        bytes[i], bytes[len(bytes)-1-i] = bytes[len(bytes)-1-i], bytes[i]
    }
    s += string(bytes)
    res, _ := strconv.Atoi(s)
    return res
}