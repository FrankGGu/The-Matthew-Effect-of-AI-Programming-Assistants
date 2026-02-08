package main

func longestCommonSubpath(n int, paths [][]int) int {
    if n == 0 {
        return 0
    }
    minLen := len(paths[0])
    for _, p := range paths {
        if len(p) < minLen {
            minLen = len(p)
        }
    }
    low, high := 0, minLen
    result := 0
    for low <= high {
        mid := (low + high) / 2
        if hasCommonSubpath(paths, mid) {
            result = mid
            low = mid + 1
        } else {
            high = mid - 1
        }
    }
    return result
}

func hasCommonSubpath(paths [][]int, length int) bool {
    if length == 0 {
        return true
    }
    hashSet := make(map[string]bool)
    for _, p := range paths {
        set := make(map[string]bool)
        for i := 0; i <= len(p)-length; i++ {
            key := ""
            for j := 0; j < length; j++ {
                key += fmt.Sprintf("%d,", p[i+j])
            }
            set[key] = true
        }
        if len(set) == 0 {
            return false
        }
        if len(hashSet) == 0 {
            hashSet = set
        } else {
            newSet := make(map[string]bool)
            for k := range set {
                if hashSet[k] {
                    newSet[k] = true
                }
            }
            hashSet = newSet
            if len(hashSet) == 0 {
                return false
            }
        }
    }
    return len(hashSet) > 0
}