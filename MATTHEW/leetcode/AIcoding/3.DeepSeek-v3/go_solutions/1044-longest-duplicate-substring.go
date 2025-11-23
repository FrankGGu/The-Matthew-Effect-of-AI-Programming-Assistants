func longestDupSubstring(s string) string {
    n := len(s)
    left, right := 1, n
    result := ""
    base := 26
    mod := 1 << 32

    nums := make([]int, n)
    for i := 0; i < n; i++ {
        nums[i] = int(s[i] - 'a')
    }

    for left <= right {
        mid := left + (right-left)/2
        start := search(mid, base, mod, nums)
        if start != -1 {
            left = mid + 1
            result = s[start : start+mid]
        } else {
            right = mid - 1
        }
    }

    return result
}

func search(L, base, mod int, nums []int) int {
    n := len(nums)
    h := 0
    for i := 0; i < L; i++ {
        h = (h*base + nums[i]) % mod
    }
    seen := make(map[int]bool)
    seen[h] = true
    aL := 1
    for i := 1; i <= L; i++ {
        aL = (aL * base) % mod
    }

    for start := 1; start < n-L+1; start++ {
        h = (h*base - nums[start-1]*aL%mod + mod) % mod
        h = (h + nums[start+L-1]) % mod
        if seen[h] {
            return start
        }
        seen[h] = true
    }
    return -1
}