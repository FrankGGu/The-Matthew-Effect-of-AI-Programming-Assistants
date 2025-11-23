func minOperations(nums []int, target int) int {
    sum := 0
    for _, num := range nums {
        sum += num
    }
    if sum < target {
        return -1
    }

    count := make([]int, 32)
    for _, num := range nums {
        power := 0
        for num > 1 {
            num >>= 1
            power++
        }
        count[power]++
    }

    res := 0
    i := 0
    for i < 31 {
        if (target>>i)&1 == 1 {
            if count[i] > 0 {
                count[i]--
            } else {
                j := i + 1
                for j < 31 && count[j] == 0 {
                    j++
                }
                if j == 31 {
                    return -1
                }
                count[j]--
                for k := i; k < j; k++ {
                    count[k]++
                }
                res += j - i
            }
        }
        count[i+1] += count[i] / 2
        i++
    }
    return res
}