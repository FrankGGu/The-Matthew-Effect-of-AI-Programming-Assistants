package main

func isSolvable(letters []string, target string) bool {
    used := make([]bool, 10)
    mapping := make(map[rune]int)
    firstLetters := make(map[rune]bool)
    var letterSet map[rune]bool

    for _, s := range letters {
        if len(s) > 0 {
            firstLetters[rune(s[0])] = true
        }
    }
    if len(target) > 0 {
        firstLetters[rune(target[0])] = true
    }

    letterSet = make(map[rune]bool)
    for _, s := range letters {
        for _, c := range s {
            letterSet[c] = true
        }
    }
    for _, c := range target {
        letterSet[c] = true
    }

    lettersList := make([]rune, 0, len(letterSet))
    for c := range letterSet {
        lettersList = append(lettersList, c)
    }

    if len(lettersList) > 10 {
        return false
    }

    var dfs func(int, int, int) bool
    dfs = func(pos int, currSum int, carry int) bool {
        if pos == len(lettersList) {
            return currSum == carry
        }

        c := lettersList[pos]
        for d := 0; d <= 9; d++ {
            if used[d] {
                continue
            }
            if d == 0 && firstLetters[c] {
                continue
            }

            sum := 0
            for _, s := range letters {
                if len(s) > 0 {
                    sum += mapping[rune(s[len(s)-1])]
                }
            }
            if len(target) > 0 {
                sum += mapping[rune(target[len(target)-1])]
            }

            used[d] = true
            mapping[c] = d
            if dfs(pos+1, sum, carry) {
                return true
            }
            used[d] = false
            delete(mapping, c)
        }

        return false
    }

    return dfs(0, 0, 0)
}