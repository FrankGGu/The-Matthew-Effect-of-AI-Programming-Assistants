func maximumTastiness(candy []int, k int) int {
    sort.Ints(candy)
    left, right := 0, candy[len(candy)-1]-candy[0]

    for left < right {
        mid := left + (right-left+1)/2
        if canDistribute(candy, k, mid) {
            left = mid
        } else {
            right = mid - 1
        }
    }

    return left
}

func canDistribute(candy []int, k int, minDiff int) bool {
    count, last := 1, candy[0]

    for i := 1; i < len(candy); i++ {
        if candy[i] - last >= minDiff {
            count++
            last = candy[i]
            if count >= k {
                return true
            }
        }
    }

    return false
}