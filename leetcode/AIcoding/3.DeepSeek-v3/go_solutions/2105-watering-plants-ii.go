func minimumRefill(plants []int, capacityA int, capacityB int) int {
    left, right := 0, len(plants)-1
    refill := 0
    a, b := capacityA, capacityB

    for left <= right {
        if left == right {
            if max(a, b) < plants[left] {
                refill++
            }
            break
        }
        if a < plants[left] {
            refill++
            a = capacityA
        }
        a -= plants[left]
        left++

        if b < plants[right] {
            refill++
            b = capacityB
        }
        b -= plants[right]
        right--
    }
    return refill
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}