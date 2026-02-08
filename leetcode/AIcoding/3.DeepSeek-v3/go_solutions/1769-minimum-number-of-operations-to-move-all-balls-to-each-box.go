func minOperations(boxes string) []int {
    n := len(boxes)
    result := make([]int, n)

    for i := 0; i < n; i++ {
        ops := 0
        for j := 0; j < n; j++ {
            if boxes[j] == '1' {
                ops += abs(j - i)
            }
        }
        result[i] = ops
    }

    return result
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}