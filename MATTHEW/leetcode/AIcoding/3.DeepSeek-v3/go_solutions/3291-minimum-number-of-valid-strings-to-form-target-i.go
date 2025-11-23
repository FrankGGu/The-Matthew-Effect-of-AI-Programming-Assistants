func minStickers(stickers []string, target string) int {
    n := len(target)
    dp := make([]int, 1<<n)
    for i := range dp {
        dp[i] = -1
    }
    dp[0] = 0

    for state := 0; state < (1<<n); state++ {
        if dp[state] == -1 {
            continue
        }
        for _, sticker := range stickers {
            now := state
            cnt := make([]int, 26)
            for _, c := range sticker {
                cnt[c-'a']++
            }
            for i := 0; i < n; i++ {
                if (state>>i)&1 == 1 {
                    continue
                }
                c := target[i]
                if cnt[c-'a'] > 0 {
                    cnt[c-'a']--
                    now |= 1 << i
                }
            }
            if dp[now] == -1 || dp[now] > dp[state]+1 {
                dp[now] = dp[state] + 1
            }
        }
    }
    return dp[(1<<n)-1]
}