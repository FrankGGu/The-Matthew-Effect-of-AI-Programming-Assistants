import "math"

func minStickers(stickers []string, target string) int {
    count := make([][]int, len(stickers))
    for i, sticker := range stickers {
        count[i] = make([]int, 26)
        for _, ch := range sticker {
            count[i][ch-'a']++
        }
    }

    targetCount := make([]int, 26)
    for _, ch := range target {
        targetCount[ch-'a']++
    }

    memo := make(map[string]int)
    var dfs func(rem string) int
    dfs = func(rem string) int {
        if len(rem) == 0 {
            return 0
        }
        if val, exists := memo[rem]; exists {
            return val
        }

        remCount := make([]int, 26)
        for _, ch := range rem {
            remCount[ch-'a']++
        }

        res := math.MaxInt32
        for _, sticker := range count {
            if sticker[rem[0]-'a'] == 0 {
                continue
            }

            newRemCount := make([]int, 26)
            for i := 0; i < 26; i++ {
                newRemCount[i] = max(0, remCount[i]-sticker[i])
            }

            newRem := ""
            for i := 0; i < 26; i++ {
                newRem += string(repeat('a'+i, newRemCount[i]))
            }

            subRes := dfs(newRem)
            if subRes != math.MaxInt32 {
                res = min(res, subRes+1)
            }
        }

        memo[rem] = res
        return res
    }

    result := dfs(target)
    if result == math.MaxInt32 {
        return -1
    }
    return result
}

func repeat(ch byte, count int) string {
    res := make([]byte, count)
    for i := range res {
        res[i] = ch
    }
    return string(res)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}