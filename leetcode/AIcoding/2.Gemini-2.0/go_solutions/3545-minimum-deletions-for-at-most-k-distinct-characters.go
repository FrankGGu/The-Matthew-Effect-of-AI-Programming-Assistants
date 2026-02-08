func characterReplacement(s string, k int) int {
	n := len(s)
	maxLen := 0
	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			freq := make(map[byte]int)
			for l := i; l <= j; l++ {
				freq[s[l]]++
			}
			maxFreq := 0
			for _, count := range freq {
				if count > maxFreq {
					maxFreq = count
				}
			}
			if j-i+1-maxFreq <= k {
				if j-i+1 > maxLen {
					maxLen = j - i + 1
				}
			}
		}
	}
	return maxLen
}

func minDeletions(s string, k int) int {
	n := len(s)
	if n == 0 {
		return 0
	}

	minDeletions := n

	for i := 0; i < (1 << n); i++ {
		sub := ""
		deletions := 0
		for j := 0; j < n; j++ {
			if (i>>j)&1 == 0 {
				deletions++
			} else {
				sub += string(s[j])
			}
		}

		if len(sub) == 0 {
			if k == 0 {
				if deletions < minDeletions {
					minDeletions = deletions
				}
			}
			continue
		}

		freq := make(map[rune]int)
		for _, r := range sub {
			freq[r]++
		}

		if len(freq) <= k {
			if deletions < minDeletions {
				minDeletions = deletions
			}
		}
	}

	return minDeletions
}

func minDeletionsSlidingWindow(s string, k int) int {
	n := len(s)
	if n == 0 {
		return 0
	}

	minDeletions := n

	for charCode := 'a'; charCode <= 'z'; charCode++ {
		for i := 0; i < n; i++ {
			for j := i; j < n; j++ {
				deletions := 0
				distinctChars := make(map[rune]int)
				for l := i; l <= j; l++ {
					distinctChars[rune(s[l])]++
				}

				if len(distinctChars) > k {
					continue
				}

				currentDeletions := 0
				for m := 0; m < n; m++ {
					if m < i || m > j {
						currentDeletions++
					}
				}

				if currentDeletions < minDeletions {
					minDeletions = currentDeletions
				}
			}
		}
	}

	return minDeletions
}

func minDeletionsOptimized(s string, k int) int {
    n := len(s)
    minDeletions := n

    for i := 0; i < (1 << n); i++ {
        sub := ""
        deletions := 0
        for j := 0; j < n; j++ {
            if (i>>j)&1 == 0 {
                deletions++
            } else {
                sub += string(s[j])
            }
        }

        if len(sub) == 0 {
            if k == 0 {
                if deletions < minDeletions {
                    minDeletions = deletions
                }
            }
            continue
        }

        freq := make(map[rune]int)
        for _, r := range sub {
            freq[r]++
        }

        if len(freq) <= k {
            if deletions < minDeletions {
                minDeletions = deletions
            }
        }
    }

    return minDeletions
}