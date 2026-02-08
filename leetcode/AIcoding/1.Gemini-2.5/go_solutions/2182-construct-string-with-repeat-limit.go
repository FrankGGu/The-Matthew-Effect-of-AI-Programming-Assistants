import (
	"strings"
)

func repeatLimitedString(s string, repeatLimit int) string {
    counts := make([]int, 26)
    for _, r := range s {
        counts[r-'a']++
    }

    var sb strings.Builder

    for i := 25; i >= 0; i-- { // i represents the current character we are trying to append (from 'z' down to 'a')
        for counts[i] > 0 { // While character 'i' is still available
            // Determine how many times we can append character 'i'.
            // It's either its remaining count or the repeatLimit, whichever is smaller.
            numToAppend := min(counts[i], repeatLimit)

            // Append character 'i' `numToAppend` times.
            for k := 0; k < numToAppend; k++ {
                sb.WriteByte(byte('a' + i))
                counts[i]--
            }

            // If character 'i' is still available after appending `repeatLimit` times,
            // it means we hit the repeatLimit. We must append a smaller character to break the sequence.
            if counts[i] > 0 {
                // Find the largest character 'j' (smaller than 'i') that is available.
                foundSmallerChar := false
                for j := i - 1; j >= 0; j-- { // Iterate from 'i-1' down to 'a'
                    if counts[j] > 0 {
                        sb.WriteByte(byte('a' + j)) // Append character 'j' once.
                        counts[j]--
                        foundSmallerChar = true
                        break // Found and used a smaller character, now we can potentially append 'i' again.
                    }
                }

                // If no smaller character 'j' was found to break the sequence,
                // we cannot append any more 'i's. Break out of the inner loop for current 'i'.
                if !foundSmallerChar {
                    break
                }
            } else {
                // If counts[i] is 0, it means we have exhausted character 'i'.
                // The outer loop will naturally move to 'i-1' in the next iteration.
                // We can break the inner loop here to avoid unnecessary checks.
                break 
            }
        }
    }

    return sb.String()
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}