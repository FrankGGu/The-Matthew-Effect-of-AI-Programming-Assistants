package main

func longestDupSubstring(s string) string {
    const base int = 26
    const mod int = 1<<61 - 1

    n := len(s)
    nums := make([]int, n)
    for i := range s {
        nums[i] = int(s[i] - 'a' + 1)
    }

    left, right := 0, n-1
    var ans int

    for left <= right {
        mid := left + (right-left)/2
        if search(nums, mid, base, mod) != -1 {
            ans = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }

    start := search(nums, ans, base, mod)
    return s[start : start+ans]
}

func search(nums []int, length int, base, mod int) int {
    if length == 0 {
        return -1
    }

    n := len(nums)
    hash := 0
    for i := 0; i < length; i++ {
        hash = (hash*base + nums[i]) % mod
    }

    seen := map[int]bool{hash: true}
    baseLen := 1
    for i := 0; i < length; i++ {
        baseLen = (baseLen * base) % mod
    }

    for start := 1; start <= n-length; start++ {
        hash = (hash*base - nums[start-1]*baseLen + nums[start+length-1]) % mod
        if hash < 0 {
            hash += mod
        }
        if seen[hash] {
            return start
        }
        seen[hash] = true
    }

    return -1
}