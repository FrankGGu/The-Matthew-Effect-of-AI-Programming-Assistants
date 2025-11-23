func maxFruits(fruits [][]int, startPos int, k int) int {
    n := len(fruits)
    maxFruits := 0
    left, right := startPos, startPos
    currentFruits := 0

    for right < n && right < startPos+k {
        currentFruits += fruits[right][1]
        right++
    }

    for left >= 0 || right < n {
        maxFruits = max(maxFruits, currentFruits)

        if right < n && (left < 0 || (startPos-left) < (right-startPos)) {
            currentFruits += fruits[right][1]
            right++
        } else {
            if left >= 0 {
                currentFruits -= fruits[left][1]
                left--
            } else {
                break
            }
        }
    }

    return maxFruits
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}