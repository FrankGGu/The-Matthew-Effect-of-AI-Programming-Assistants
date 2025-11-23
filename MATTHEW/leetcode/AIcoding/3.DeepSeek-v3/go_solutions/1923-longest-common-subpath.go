func longestCommonSubpath(n int, paths [][]int) int {
    minLen := len(paths[0])
    for _, path := range paths {
        if len(path) < minLen {
            minLen = len(path)
        }
    }

    left, right := 1, minLen
    result := 0

    base, mod := 100001, 100000000019

    for left <= right {
        mid := left + (right - left) / 2
        if check(paths, mid, base, mod) {
            result = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }

    return result
}

func check(paths [][]int, l int, base int, mod int) bool {
    if l == 0 {
        return true
    }

    hashMap := make(map[int]int)
    baseL := 1
    for i := 0; i < l - 1; i++ {
        baseL = (baseL * base) % mod
    }

    for i, path := range paths {
        currentHash := 0
        seen := make(map[int]bool)
        hashSet := make(map[int]struct{})

        for j := 0; j < len(path); j++ {
            if j >= l {
                currentHash = (currentHash - (path[j - l] * baseL) % mod + mod) % mod
            }
            currentHash = (currentHash * base + path[j]) % mod
            if j >= l - 1 {
                if i == 0 {
                    hashSet[currentHash] = struct{}{}
                } else {
                    if _, exists := hashSet[currentHash]; exists {
                        seen[currentHash] = true
                    }
                }
            }
        }

        if i == 0 {
            for h := range hashSet {
                hashMap[h]++
            }
        } else {
            temp := make(map[int]int)
            for h := range seen {
                temp[h] = hashMap[h] + 1
            }
            hashMap = temp
            if len(hashMap) == 0 {
                return false
            }
        }
    }

    return len(hashMap) > 0
}