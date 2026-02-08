func numberOfSubstrings(s string) int {
    n := len(s)
    count := 0
    lastA := -1
    lastB := -1
    lastC := -1

    for right := 0; right < n; right++ {
        if s[right] == 'a' {
            lastA = right
        } else if s[right] == 'b' {
            lastB = right
        } else if s[right] == 'c' {
            lastC = right
        }

        if lastA != -1 && lastB != -1 && lastC != -1 {
            // All three characters 'a', 'b', 'c' have been seen at least once
            // up to the current 'right' index.
            // The minimum of their last seen indices (lastA, lastB, lastC)
            // determines the leftmost possible start 'left' for a valid substring
            // s[left...right].
            // Any 'left' from 0 up to this minimum index will form a valid substring
            // s[left...right] that contains 'a', 'b', and 'c'.
            // The number of such 'left' values is (min_index + 1).
            m := lastA
            if lastB < m {
                m = lastB
            }
            if lastC < m {
                m = lastC
            }
            count += m + 1
        }
    }

    return count
}