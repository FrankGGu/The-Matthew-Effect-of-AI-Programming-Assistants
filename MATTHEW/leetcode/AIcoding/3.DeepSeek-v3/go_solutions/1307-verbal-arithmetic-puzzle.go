func isSolvable(words []string, result string) bool {
    allWords := append([]string{}, words...)
    allWords = append(allWords, result)
    uniqueChars := make(map[byte]bool)
    firstChars := make(map[byte]bool)

    for _, word := range allWords {
        for i := 0; i < len(word); i++ {
            c := word[i]
            uniqueChars[c] = true
            if i == 0 && len(word) > 1 {
                firstChars[c] = true
            }
        }
    }

    chars := make([]byte, 0, len(uniqueChars))
    for c := range uniqueChars {
        chars = append(chars, c)
    }

    n := len(chars)
    if n > 10 {
        return false
    }

    perm := make([]int, 10)
    used := make([]bool, 10)

    var backtrack func(int) bool
    backtrack = func(pos int) bool {
        if pos == n {
            return check(words, result, chars, perm)
        }

        for d := 0; d < 10; d++ {
            if !used[d] {
                if d == 0 {
                    c := chars[pos]
                    if firstChars[c] {
                        continue
                    }
                }
                perm[pos] = d
                used[d] = true
                if backtrack(pos + 1) {
                    return true
                }
                used[d] = false
            }
        }
        return false
    }

    return backtrack(0)
}

func check(words []string, result string, chars []byte, perm []int) bool {
    charToDigit := make(map[byte]int)
    for i, c := range chars {
        charToDigit[c] = perm[i]
    }

    sum := 0
    for _, word := range words {
        num := 0
        for _, c := range word {
            num = num * 10 + charToDigit[byte(c)]
        }
        sum += num
    }

    resNum := 0
    for _, c := range result {
        resNum = resNum * 10 + charToDigit[byte(c)]
    }

    return sum == resNum
}