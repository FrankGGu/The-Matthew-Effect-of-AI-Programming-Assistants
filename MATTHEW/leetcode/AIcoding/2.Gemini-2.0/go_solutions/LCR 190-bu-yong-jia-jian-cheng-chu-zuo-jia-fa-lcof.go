func getSum(s string, mapping map[byte]int) int {
    res := 0
    for _, c := range s {
        res = res*10 + mapping[byte(c)]
    }
    return res
}

func isSolvable(words []string, result string) bool {
    mapping := make(map[byte]int)
    used := make([]bool, 10)
    letters := make(map[byte]bool)
    for _, word := range words {
        for i := range word {
            letters[word[i]] = true
        }
    }
    for i := range result {
        letters[result[i]] = true
    }

    letterList := make([]byte, 0, len(letters))
    for letter := range letters {
        letterList = append(letterList, letter)
    }

    var backtrack func(int) bool
    backtrack = func(index int) bool {
        if index == len(letterList) {
            sum := 0
            for _, word := range words {
                sum += getSum(word, mapping)
            }
            return sum == getSum(result, mapping)
        }

        letter := letterList[index]
        for digit := 0; digit <= 9; digit++ {
            if used[digit] {
                continue
            }

            mapping[letter] = digit
            used[digit] = true

            valid := true
            for _, word := range words {
                if len(word) > 1 && mapping[word[0]] == 0 {
                    valid = false
                    break
                }
            }
            if len(result) > 1 && mapping[result[0]] == 0 {
                valid = false
            }

            if valid && backtrack(index+1) {
                return true
            }

            used[digit] = false
            delete(mapping, letter)
        }

        return false
    }

    return backtrack(0)
}