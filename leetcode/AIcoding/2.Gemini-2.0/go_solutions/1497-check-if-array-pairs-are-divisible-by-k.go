func canArrange(arr []int, k int) bool {
    remainders := make(map[int]int)
    for _, num := range arr {
        remainder := num % k
        if remainder < 0 {
            remainder += k
        }
        remainders[remainder]++
    }

    for remainder, count := range remainders {
        if remainder == 0 {
            if count%2 != 0 {
                return false
            }
        } else if remainder*2 == k {
            if count%2 != 0 {
                return false
            }
        } else {
            complement := (k - remainder) % k
            if remainders[complement] != count {
                return false
            }
        }
    }

    return true
}