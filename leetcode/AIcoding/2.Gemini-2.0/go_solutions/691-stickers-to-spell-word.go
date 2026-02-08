import (
	"math"
)

func minStickers(stickers []string, target string) int {
	n := len(target)
	dp := make([]int, 1<<n)
	for i := 1; i < 1<<n; i++ {
		dp[i] = -1
	}

	var solve func(mask int) int
	solve = func(mask int) int {
		if dp[mask] != -1 {
			return dp[mask]
		}
		if mask == 0 {
			dp[mask] = 0
			return 0
		}

		res := math.MaxInt32
		for _, sticker := range stickers {
			newMask := mask
			counts := make([]int, 26)
			for _, c := range sticker {
				counts[c-'a']++
			}

			for i := 0; i < n; i++ {
				if (mask>>i)&1 == 1 && counts[target[i]-'a'] > 0 {
					counts[target[i]-'a']--
					newMask ^= (1 << i)
				}
			}

			if newMask != mask {
				count := solve(newMask)
				if count != math.MaxInt32 {
					res = min(res, count+1)
				}
			}
		}

		dp[mask] = res
		return res
	}

	ans := solve((1<<n) - 1)
	if ans == math.MaxInt32 {
		return -1
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}