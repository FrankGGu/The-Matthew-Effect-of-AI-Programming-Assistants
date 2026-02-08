import (
	"sort"
)

func latestTime(s string, indices []int) string {
	n := len(s)
	chars := []byte(s)
	m := len(indices)
	available := make([]int, 0, n)
	for i := 0; i < m; i++ {
		available = append(available, indices[i])
	}
	sort.Ints(available)
	sort.Slice(chars, func(i, j int) bool {
		if s[i] == '?' && s[j] != '?' {
			return true
		}
		if s[i] != '?' && s[j] == '?' {
			return false
		}
		return i < j
	})

	availableChars := make([]byte, 0)
	for i := 0; i < n; i++ {
		if chars[i] == '?' {
			availableChars = append(availableChars, ' ')
		}
	}

	for i := 0; i < len(availableChars); i++ {
		availableChars[i] = 'z' - byte(i)
	}

	result := []byte(s)
	k := 0
	for _, index := range indices {
		result[index] = availableChars[k]
		k++
	}

	return string(result)
}