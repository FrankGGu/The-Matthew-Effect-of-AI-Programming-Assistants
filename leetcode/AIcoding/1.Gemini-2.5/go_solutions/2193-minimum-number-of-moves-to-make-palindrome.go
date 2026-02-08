package main

func minMovesToMakePalindrome(s string) int {
	chars := []byte(s)
	n := len(chars)
	moves := 0
	left := 0
	right := n - 1

	for left < right {
		if chars[left] == chars[right] {
			left++
			right--
			continue
		}

		// Find the rightmost character matching chars[left] in the remaining substring
		k := right
		for k > left {
			if chars[k] == chars[left] {
				break
			}
			k--
		}

		if k == left {
			// chars[left] is the unique middle character.
			// It needs to be moved to the center of the remaining substring.
			// The number of swaps to move chars[left] to the middle is (right - left) / 2.
			moves += (right - left) / 2
			left++ // This character is now effectively placed in the middle
		} else {
			// Found a match at index k for chars[left].
			// Move chars[k] to chars[right] by adjacent swaps.
			// This takes (right - k) swaps.
			moves += (right - k)

			// Shift characters from k+1 to right one position to the left
			// to make space for original chars[k] at chars[right].
			temp := chars[k]
			for i := k; i < right; i++ {
				chars[i] = chars[i+1]
			}
			chars[right] = temp // Place the matched character at the right end

			left++
			right--
		}
	}

	return moves
}