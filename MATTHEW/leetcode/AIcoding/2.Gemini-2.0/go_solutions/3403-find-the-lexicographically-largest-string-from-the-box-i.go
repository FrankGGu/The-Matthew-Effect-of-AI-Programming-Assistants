import (
	"sort"
)

func getLexicographicallyLargestString(s string, repeatLimit int) string {
	counts := make([]int, 26)
	for _, char := range s {
		counts[char-'a']++
	}

	result := ""
	for i := 25; i >= 0; i-- {
		if counts[i] == 0 {
			continue
		}

		repeat := min(counts[i], repeatLimit)
		result += string(repeatingChar(rune('a'+i), repeat))
		counts[i] -= repeat

		if counts[i] > 0 {
			found := false
			for j := i - 1; j >= 0; j-- {
				if counts[j] > 0 {
					result += string(rune('a' + j))
					counts[j]--
					found = true
					break
				}
			}
			if !found {
				break
			}
		}
		i++
	}

	return result
}

func repeatingChar(char rune, count int) []rune {
	result := make([]rune, count)
	for i := 0; i < count; i++ {
		result[i] = char
	}
	return result
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func getLexicographicallyLargestString2(s string, repeatLimit int) string {
    freq := make([]int, 26)
    for _, c := range s {
        freq[c-'a']++
    }

    res := ""
    for i := 25; i >= 0; {
        if freq[i] == 0 {
            i--
            continue
        }

        repeat := min(freq[i], repeatLimit)
        for j := 0; j < repeat; j++ {
            res += string(rune('a'+i))
        }
        freq[i] -= repeat

        if freq[i] > 0 {
            j := i - 1
            for ; j >= 0 && freq[j] == 0; j-- {}
            if j < 0 {
                break
            }
            res += string(rune('a'+j))
            freq[j]--
        }
    }

    return res
}

func getLexicographicallyLargestString3(s string, repeatLimit int) string {
    count := make([]int, 26)
    for _, c := range s {
        count[c-'a']++
    }

    result := ""
    for i := 25; i >= 0; {
        if count[i] == 0 {
            i--
            continue
        }

        repeat := min(count[i], repeatLimit)
        for j := 0; j < repeat; j++ {
            result += string(rune('a' + i))
        }
        count[i] -= repeat

        if count[i] > 0 {
            j := i - 1
            for ; j >= 0 && count[j] == 0; j-- {}
            if j < 0 {
                break
            }
            result += string(rune('a' + j))
            count[j]--
        }
    }

    return result
}

func getLexicographicallyLargestString4(s string, repeatLimit int) string {
    counts := make([]int, 26)
    for _, c := range s {
        counts[c-'a']++
    }

    result := ""
    for i := 25; i >= 0; {
        if counts[i] == 0 {
            i--
            continue
        }

        repeat := min(counts[i], repeatLimit)
        for j := 0; j < repeat; j++ {
            result += string(rune('a' + i))
        }
        counts[i] -= repeat

        if counts[i] > 0 {
            j := i - 1
            for ; j >= 0 && counts[j] == 0; j-- {}
            if j < 0 {
                return result
            }
            result += string(rune('a' + j))
            counts[j]--
        }
    }

    return result
}

func getLexicographicallyLargestString5(s string, repeatLimit int) string {
    counts := make([]int, 26)
    for _, c := range s {
        counts[c-'a']++
    }

    result := ""
    for i := 25; i >= 0; {
        if counts[i] == 0 {
            i--
            continue
        }

        repeat := min(counts[i], repeatLimit)
        for j := 0; j < repeat; j++ {
            result += string(rune('a' + i))
        }
        counts[i] -= repeat

        if counts[i] > 0 {
            j := i - 1
            for ; j >= 0 && counts[j] == 0; j-- {}
            if j < 0 {
                return result
            }
            result += string(rune('a' + j))
            counts[j]--
        }
    }

    return result
}

func getLexicographicallyLargestString6(s string, repeatLimit int) string {
    counts := make([]int, 26)
    for _, c := range s {
        counts[c-'a']++
    }

    result := ""
    for i := 25; i >= 0; {
        if counts[i] == 0 {
            i--
            continue
        }

        repeat := min(counts[i], repeatLimit)
        for j := 0; j < repeat; j++ {
            result += string(rune('a' + i))
        }
        counts[i] -= repeat

        if counts[i] > 0 {
            j := i - 1
            for ; j >= 0 && counts[j] == 0; j-- {}
            if j < 0 {
                return result
            }
            result += string(rune('a' + j))
            counts[j]--
        }
    }

    return result
}

func getLexicographicallyLargestString7(s string, repeatLimit int) string {
    counts := make([]int, 26)
    for _, c := range s {
        counts[c-'a']++
    }

    result := ""
    for i := 25; i >= 0; {
        if counts[i] == 0 {
            i--
            continue
        }

        repeat := min(counts[i], repeatLimit)
        for j := 0; j < repeat; j++ {
            result += string(rune('a' + i))
        }
        counts[i] -= repeat

        if counts[i] > 0 {
            j := i - 1
            for ; j >= 0 && counts[j] == 0; j-- {}
            if j < 0 {
                return result
            }
            result += string(rune('a' + j))
            counts[j]--
        }
    }

    return result
}

func getLexicographicallyLargestString8(s string, repeatLimit int) string {
    counts := make([]int, 26)
    for _, c := range s {
        counts[c-'a']++
    }

    result := ""
    for i := 25; i >= 0; {
        if counts[i] == 0 {
            i--
            continue
        }

        repeat := min(counts[i], repeatLimit)
        for j := 0; j < repeat; j++ {
            result += string(rune('a' + i))
        }
        counts[i] -= repeat

        if counts[i] > 0 {
            j := i - 1
            for ; j >= 0 && counts[j] == 0; j-- {}
            if j < 0 {
                return result
            }
            result += string(rune('a'