func countSubsequences(nums []int) int {
    const mod = 1e9 + 7
    n := len(nums)
    res := 0

    for i := 0; i < n; i++ {
        freq := make(map[int]int)
        left := 0
        for j := i; j < n; j++ {
            num := nums[j]
            freq[num]++
            if freq[num] == 1 {
                left++
            }
            if (j-i+1) % 2 == 1 {
                m := (j - i) / 2 + i
                mode := nums[m]
                if freq[mode] == 1 {
                    res = (res + 1) % mod
                }
            }
        }
    }

    return res
}