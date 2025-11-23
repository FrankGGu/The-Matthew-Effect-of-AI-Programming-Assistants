package main

import (
	"math"
)

func minStickers(stickers []string, target string) int {
	n := len(target)

	stickerFreqs := make([][26]int, len(stickers))
	for i, sticker := range stickers {
		for _, char := range sticker {
			stickerFreqs[i][char-'a']++
		}
	}

	dp := make([]int, 1<<n)
	for i := range dp {
		dp[i] = math.MaxInt32
	}
	dp[0] = 0

	for mask := 0; mask < (1 << n); mask++ {
		if dp[mask] == math.MaxInt32 {
			continue
		}

		firstCharIdx := -1
		for i := 0; i < n; i++ {
			if (mask>>i)&1 == 0 {
				firstCharIdx = i
				break
			}
		}

		if firstCharIdx == -1 {
			continue
		}

		for _, sFreq := range stickerFreqs {
			if sFreq[target[firstCharIdx]-'a'] == 0 {
				continue
			}

			newMask := mask
			tempSFreq := [26]int{}
			copy(tempSFreq[:], sFreq[:])

			for i := 0; i < n; i++ {
				if (newMask>>i)&1 == 0 && tempSFreq[target[i]-'a'] > 0 {
					newMask |= (1 << i)
					tempSFreq[target[i]-'a']--
				}
			}

			dp[newMask] = min(dp[newMask], dp[mask]+1)
		}
	}

	if dp[(1<<n)-1] == math.MaxInt32 {
		return -1
	}
	return dp[(1<<n)-1]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}