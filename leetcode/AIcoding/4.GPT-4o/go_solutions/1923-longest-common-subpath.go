import "hash/fnv"

func longestCommonSubpath(n int, paths [][]int) int {
    base := int(1e9 + 7)
    maxLen := 0

    check := func(len int) bool {
        seen := make(map[uint64]struct{})
        hash := uint64(0)
        power := uint64(1)

        for i := 0; i < len; i++ {
            hash = hash*base + uint64(paths[0][i])
            power *= uint64(base)
        }
        seen[hash] = struct{}{}

        for start := 1; start+len <= n; start++ {
            hash = hash*base - uint64(paths[0][start-1])*power + uint64(paths[0][start+len-1])
            seen[hash] = struct{}{}
        }

        for i := 1; i < len(paths); i++ {
            hash = 0
            for j := 0; j < len; j++ {
                hash = hash*base + uint64(paths[i][j])
            }
            if _, exists := seen[hash]; exists {
                return true
            }
            for start := 1; start+len <= n; start++ {
                hash = hash*base - uint64(paths[i][start-1])*power + uint64(paths[i][start+len-1])
                if _, exists := seen[hash]; exists {
                    return true
                }
            }
        }
        return false
    }

    left, right := 1, n
    for left <= right {
        mid := (left + right) / 2
        if check(mid) {
            maxLen = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return maxLen
}