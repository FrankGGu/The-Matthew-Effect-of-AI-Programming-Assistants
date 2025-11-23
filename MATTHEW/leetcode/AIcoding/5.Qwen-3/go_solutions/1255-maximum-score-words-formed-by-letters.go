package main

func maxScoreWords(words []string, letters []byte) int {
    var count [26]int
    for _, c := range letters {
        count[c-'a']++
    }

    var score [26]int
    score[0] = 1
    score[1] = 3
    score[2] = 3
    score[3] = 2
    score[4] = 1
    score[5] = 3
    score[6] = 3
    score[7] = 2
    score[8] = 1
    score[9] = 1
    score[10] = 3
    score[11] = 3
    score[12] = 2
    score[13] = 2
    score[14] = 1
    score[15] = 1
    score[16] = 3
    score[17] = 3
    score[18] = 2
    score[19] = 1
    score[20] = 2
    score[21] = 2
    score[22] = 1
    score[23] = 2
    score[24] = 1
    score[25] = 2

    var res int
    var dfs func(int, [26]int)
    dfs = func(i int, cur [26]int) {
        if i == len(words) {
            return
        }
        // Try to use words[i]
        valid := true
        for j := 0; j < 26; j++ {
            if cur[j] > count[j] {
                valid = false
                break
            }
        }
        if valid {
            temp := cur
            for j := 0; j < 26; j++ {
                temp[j] += countWord(words[i], j)
            }
            total := 0
            for j := 0; j < 26; j++ {
                total += temp[j] * score[j]
            }
            if total > res {
                res = total
            }
            dfs(i+1, temp)
        }
        // Try not to use words[i]
        dfs(i+1, cur)
    }

    dfs(0, count)
    return res
}

func countWord(word string, c byte) int {
    res := 0
    for i := 0; i < len(word); i++ {
        if word[i] == c {
            res++
        }
    }
    return res
}