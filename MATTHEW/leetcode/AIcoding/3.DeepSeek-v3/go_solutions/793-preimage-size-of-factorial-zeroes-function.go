func preimageSizeFZF(K int) int {
    low, high := 0, 5*(K+1)
    for low <= high {
        mid := low + (high-low)/2
        zeros := trailingZeroes(mid)
        if zeros == K {
            return 5
        } else if zeros < K {
            low = mid + 1
        } else {
            high = mid - 1
        }
    }
    return 0
}

func trailingZeroes(n int) int {
    count := 0
    for n > 0 {
        n /= 5
        count += n
    }
    return count
}