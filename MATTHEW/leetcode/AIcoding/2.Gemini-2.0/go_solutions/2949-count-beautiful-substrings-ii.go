func beautifulSubstrings(s string, k int) int64 {
	n := len(s)
	ans := int64(0)
	vowels := "aeiou"
	count := make(map[int]int)
	count[0] = 1
	vowelCount := 0
	for i := 0; i < n; i++ {
		isVowel := false
		for j := 0; j < len(vowels); j++ {
			if s[i] == vowels[j] {
				isVowel = true
				break
			}
		}
		if isVowel {
			vowelCount++
		}
		consonantCount := (i + 1) - vowelCount
		diff := vowelCount - consonantCount
		rem := diff % k
		if rem < 0 {
			rem += k
		}

		ans += int64(count[rem])
		count[rem]++

		for j := i - 1; j >=0; j-- {
			vowelSubCount := 0
			consonantSubCount := 0
			for l := j; l <= i; l++ {
				isSubVowel := false
				for m := 0; m < len(vowels); m++ {
					if s[l] == vowels[m] {
						isSubVowel = true
						break
					}
				}
				if isSubVowel {
					vowelSubCount++
				} else {
					consonantSubCount++
				}
			}

			if vowelSubCount == consonantSubCount {
				prod := vowelSubCount * consonantSubCount
				if prod % k == 0 {

				}
			}
		}
	}

	vowelCount = 0
	for i := 0; i < n; i++ {
		isVowel := false
		for j := 0; j < len(vowels); j++ {
			if s[i] == vowels[j] {
				isVowel = true
				break
			}
		}
		if isVowel {
			vowelCount++
		}
		consonantCount := (i + 1) - vowelCount
		if vowelCount*vowelCount % k == 0 {
			for j := i; j >= 0; j-- {
				vowelSubCount := 0
				consonantSubCount := 0
				for l := j; l <= i; l++ {
					isSubVowel := false
					for m := 0; m < len(vowels); m++ {
						if s[l] == vowels[m] {
							isSubVowel = true
							break
						}
					}
					if isSubVowel {
						vowelSubCount++
					} else {
						consonantSubCount++
					}
				}
				if vowelSubCount == consonantSubCount {
					prod := vowelSubCount * consonantSubCount
					if prod % k == 0 {
						ans++
					}
				}
			}
		}
	}

	vowelCount = 0
	for i := 0; i < n; i++ {
		isVowel := false
		for j := 0; j < len(vowels); j++ {
			if s[i] == vowels[j] {
				isVowel = true
				break
			}
		}
		if isVowel {
			vowelCount++
		}
		consonantCount := (i + 1) - vowelCount
		if consonantCount*consonantCount % k == 0 {
			for j := i; j >= 0; j-- {
				vowelSubCount := 0
				consonantSubCount := 0
				for l := j; l <= i; l++ {
					isSubVowel := false
					for m := 0; m < len(vowels); m++ {
						if s[l] == vowels[m] {
							isSubVowel = true
							break
						}
					}
					if isSubVowel {
						vowelSubCount++
					} else {
						consonantSubCount++
					}
				}
				if vowelSubCount == consonantSubCount {
					prod := vowelSubCount * consonantSubCount
					if prod % k == 0 {
						ans++
					}
				}
			}
		}
	}

	count = make(map[int]int)
	count[0] = 1
	vowelCount = 0
	for i := 0; i < n; i++ {
		isVowel := false
		for j := 0; j < len(vowels); j++ {
			if s[i] == vowels[j] {
				isVowel = true
				break
			}
		}
		if isVowel {
			vowelCount++
		}
		consonantCount := (i + 1) - vowelCount
		diff := vowelCount - consonantCount
		rem := diff % k
		if rem < 0 {
			rem += k
		}
		ans -= int64(count[rem])
		count[rem]++
	}

	count = make(map[int]int)
	count[0] = 1
	vowelCount = 0
	for i := 0; i < n; i++ {
		isVowel := false
		for j := 0; j < len(vowels); j++ {
			if s[i] == vowels[j] {
				isVowel = true
				break
			}
		}
		if isVowel {
			vowelCount++
		}
		consonantCount := (i + 1) - vowelCount
		diff := vowelCount - consonantCount
		rem := diff % k
		if rem < 0 {
			rem += k
		}
		//ans += int64(count[rem])
		//count[rem]++
	}

	count = make(map[int]int)
	count[0] = 1
	vowelCount = 0
	for i := 0; i < n; i++ {
		isVowel := false
		for j := 0; j < len(vowels); j++ {
			if s[i] == vowels[j] {
				isVowel = true
				break
			}
		}
		if isVowel {
			vowelCount++
		}
		consonantCount := (i + 1) - vowelCount
		diff := vowelCount - consonantCount
		rem := diff % k
		if rem < 0 {
			rem += k
		}
		//ans -= int64(count[rem])
		//count[rem]++
	}

	ans = 0
	for i := 0; i < n; i++ {
		vowelCount := 0
		consonantCount := 0
		for j := i; j < n; j++ {
			isVowel := false
			for l := 0; l < len(vowels); l++ {
				if s[j] == vowels[l] {
					isVowel = true
					break
				}
			}
			if isVowel {
				vowelCount++
			} else {
				consonantCount++
			}
			if vowelCount == consonantCount && (vowelCount * consonantCount) % k == 0 {
				ans++
			}
		}
	}
	return ans
}