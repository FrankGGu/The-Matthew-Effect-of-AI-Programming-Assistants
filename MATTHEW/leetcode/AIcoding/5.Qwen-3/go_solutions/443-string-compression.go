package main

func compress(chars []byte) int {
    n := len(chars)
    if n == 0 {
        return 0
    }
    var result int
    currentChar := chars[0]
    count := 1
    for i := 1; i < n; i++ {
        if chars[i] == currentChar {
            count++
        } else {
            result += writeCharAndCount(chars, result, currentChar, count)
            currentChar = chars[i]
            count = 1
        }
    }
    result += writeCharAndCount(chars, result, currentChar, count)
    return result
}

func writeCharAndCount(chars []byte, index int, char byte, count int) int {
    chars[index] = char
    index++
    if count > 1 {
        digits := []byte{}
        for count > 0 {
            digits = append(digits, '0'+byte(count%10))
            count /= 10
        }
        for i := len(digits) - 1; i >= 0; i-- {
            chars[index] = digits[i]
            index++
        }
    }
    return index
}