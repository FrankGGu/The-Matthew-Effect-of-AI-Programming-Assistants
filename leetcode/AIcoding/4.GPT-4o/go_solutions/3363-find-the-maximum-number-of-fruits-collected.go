func maxFruits(fruits []int, startPos int, k int) int {
    n := len(fruits)
    left, right := startPos, startPos
    totalFruits := 0

    for left > 0 && k > 0 {
        left--
        k--
    }

    for right < n && k > 0 {
        right++
        k--
    }

    for right < n {
        totalFruits += fruits[right]
        right++
        for left >= 0 && (right-left-1) > k {
            totalFruits -= fruits[left]
            left++
        }
        if (right-left-1) <= k {
            totalFruits += fruits[left]
        }
    }

    return totalFruits
}