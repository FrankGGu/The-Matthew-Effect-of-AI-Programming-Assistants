func maximumRemovals(s string, p string, removable []int) int {
    n := len(s)
    m := len(p)
    k := len(removable)

    check := func(mid int) bool {
        removed := make([]bool, n)
        for i := 0; i < mid; i++ {
            removed[removable[i]] = true
        }

        sPtr := 0
        pPtr := 0

        for sPtr < n && pPtr < m {
            if removed[sPtr] {
                sPtr++
                continue
            }
            if s[sPtr] == p[pPtr] {
                pPtr++
            }
            sPtr++
        }
        return pPtr == m
    }

    low := 0
    high := k
    ans := 0

    for low <= high {
        mid := low + (high - low) / 2
        if check(mid) {
            ans = mid
            low = mid + 1
        } else {
            high = mid - 1
        }
    }

    return ans
}