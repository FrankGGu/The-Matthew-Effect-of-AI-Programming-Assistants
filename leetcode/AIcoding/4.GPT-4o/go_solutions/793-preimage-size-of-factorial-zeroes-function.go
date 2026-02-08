func preimageSizeFZF(K int) int {
    low, high := 0, 5*(K+1)
    for low < high {
        mid := (low + high) / 2
        if trailingZeroes(mid) < K {
            low = mid + 1
        } else {
            high = mid
        }
    }
    if trailingZeroes(low) != K {
        return 0
    }
    count := 0
    for i := low; trailingZeroes(i) == K; i++ {
        count++
    }
    return count
}

func trailingZeroes(n int) int {
    count := 0
    for n > 0 {
        n /= 5
        count += n
    }
    return count
}