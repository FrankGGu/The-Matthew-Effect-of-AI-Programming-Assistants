func maxDistance(colors []int) int {
    left := -1
    right := -1
    n := len(colors)

    for i := 0; i < n; i++ {
        if left == -1 || colors[i] != colors[left] {
            left = i
        }
        if right == -1 || colors[i] != colors[right] {
            right = i
        }
    }

    return max(abs(left-n+1), abs(right))
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}