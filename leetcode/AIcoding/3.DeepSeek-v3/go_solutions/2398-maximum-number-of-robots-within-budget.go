func maximumRobots(chargeTimes []int, runningCosts []int, budget int64) int {
    n := len(chargeTimes)
    left := 0
    maxLen := 0
    sum := 0
    deque := make([]int, 0)

    for right := 0; right < n; right++ {
        sum += runningCosts[right]

        for len(deque) > 0 && chargeTimes[deque[len(deque)-1]] <= chargeTimes[right] {
            deque = deque[:len(deque)-1]
        }
        deque = append(deque, right)

        for left <= right && int64(chargeTimes[deque[0]]) + int64(right - left + 1) * int64(sum) > budget {
            sum -= runningCosts[left]
            if deque[0] == left {
                deque = deque[1:]
            }
            left++
        }

        if left <= right {
            if right - left + 1 > maxLen {
                maxLen = right - left + 1
            }
        }
    }

    return maxLen
}