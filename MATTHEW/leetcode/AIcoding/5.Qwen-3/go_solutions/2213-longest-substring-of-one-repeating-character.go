package main

func longestRepeatingSubstring(s string) int {
    n := len(s)
    l, r := 0, n-1
    maxLen := 0

    for l <= r {
        mid := (l + r) / 2
        seen := make(map[string]bool)
        found := false

        for i := 0; i <= n-mid; i++ {
            substr := s[i : i+mid]
            if seen[substr] {
                found = true
                break
            }
            seen[substr] = true
        }

        if found {
            maxLen = mid
            l = mid + 1
        } else {
            r = mid - 1
        }
    }

    return maxLen
}