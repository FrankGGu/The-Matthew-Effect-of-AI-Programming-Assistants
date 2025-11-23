func minimumIncompatibility(nums []int, k int) int {
    n := len(nums)
    if n%k != 0 {
        return -1
    }
    size := n / k
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
        if freq[num] > k {
            return -1
        }
    }

    memo := make(map[int]int)
    var dfs func(mask int) int
    dfs = func(mask int) int {
        if mask == (1<<n)-1 {
            return 0
        }
        if val, ok := memo[mask]; ok {
            return val
        }
        res := math.MaxInt32
        remaining := make([]int, 0)
        for i := 0; i < n; i++ {
            if mask&(1<<i) == 0 {
                remaining = append(remaining, nums[i])
            }
        }
        unique := make(map[int]bool)
        for _, num := range remaining {
            unique[num] = true
        }
        uniqueNums := make([]int, 0, len(unique))
        for num := range unique {
            uniqueNums = append(uniqueNums, num)
        }
        m := len(uniqueNums)
        for subset := 1; subset < (1 << m); subset++ {
            bits := bits.OnesCount(uint(subset))
            if bits != size {
                continue
            }
            current := make([]int, 0)
            for i := 0; i < m; i++ {
                if subset&(1<<i) != 0 {
                    current = append(current, uniqueNums[i])
                }
            }
            if len(current) != size {
                continue
            }
            valid := true
            for i := 0; i < len(current); i++ {
                for j := i + 1; j < len(current); j++ {
                    if current[i] == current[j] {
                        valid = false
                        break
                    }
                }
                if !valid {
                    break
                }
            }
            if !valid {
                continue
            }
            minVal, maxVal := current[0], current[0]
            for _, num := range current {
                if num < minVal {
                    minVal = num
                }
                if num > maxVal {
                    maxVal = num
                }
            }
            incompatibility := maxVal - minVal
            newMask := mask
            for i := 0; i < n; i++ {
                if mask&(1<<i) == 0 {
                    for _, num := range current {
                        if nums[i] == num {
                            newMask |= 1 << i
                            break
                        }
                    }
                }
            }
            next := dfs(newMask)
            if next != math.MaxInt32 {
                if incompatibility+next < res {
                    res = incompatibility + next
                }
            }
        }
        memo[mask] = res
        return res
    }
    ans := dfs(0)
    if ans == math.MaxInt32 {
        return -1
    }
    return ans
}