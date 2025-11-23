import (
	"sort"
)

func longestSpecialSubstring(s string) int {
	lengthsMap := make(map[byte][]int)

	i := 0
	for i < len(s) {
		char := s[i]
		j := i
		for j < len(s) && s[j] == char {
			j++
		}
		length := j - i
		lengthsMap[char] = append(lengthsMap[char], length)
		i = j
	}

	maxOverallLen := -1

	for _, lengths := range lengthsMap {
		// Sort lengths for the current character in descending order.
		// Example: for 'a', if s contains "aaaaa" and "aa", lengths would be [5, 2].
		sort.Slice(lengths, func(a, b int) bool {
			return lengths[a] > lengths[b]
		})

		// Binary search for the maximum length `targetLen` for this character
		// such that it can be formed at least 3 times.
		// The possible range for `targetLen` is [1, lengths[0]] (the longest block of this character).
		low, high := 1, lengths[0]
		currentMaxLenForChar := -1

		for low <= high {
			mid := low + (high-low)/2

			count := 0
			// Calculate how many times a special substring of length `mid` can be formed
			// from the existing blocks of this character.
			for _, l := range lengths {
				if l >= mid {
					count += (l - mid + 1)
				} else {
					// Since lengths are sorted descending, no further lengths will be >= mid.
					// We can break early.
					break
				}
			}

			if count >= 3 {
				// If we can form `mid` at least 3 times, `mid` is a possible answer.
				// Try to find an even longer `targetLen`.
				currentMaxLenForChar = mid
				low = mid + 1
			} else {
				// If `mid` cannot be formed 3 times, we need to try a shorter `targetLen`.
				high = mid - 1
			}
		}

		if currentMaxLenForChar > maxOverallLen {
			maxOverallLen = currentMaxLenForChar
		}
	}

	return maxOverallLen
}