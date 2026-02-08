func findValidSplit(nums []int) int {
    n := len(nums)
    if n == 1 {
        return -1
    }

    left := make(map[int]int)
    right := make(map[int]int)

    for _, num := range nums {
        factors := getPrimeFactors(num)
        for p, cnt := range factors {
            right[p] += cnt
        }
    }

    common := 0
    for i := 0; i < n-1; i++ {
        factors := getPrimeFactors(nums[i])
        for p, cnt := range factors {
            if left[p] == 0 && right[p] > 0 {
                common++
            }
            left[p] += cnt
            right[p] -= cnt
            if right[p] == 0 {
                common--
            }
        }
        if common == 0 {
            return i
        }
    }

    return -1
}

func getPrimeFactors(x int) map[int]int {
    factors := make(map[int]int)
    for i := 2; i*i <= x; i++ {
        for x%i == 0 {
            factors[i]++
            x /= i
        }
    }
    if x > 1 {
        factors[x]++
    }
    return factors
}