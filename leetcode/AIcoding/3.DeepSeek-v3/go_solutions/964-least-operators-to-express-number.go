func leastOpsExpressTarget(x int, target int) int {
    pos, neg, k := 0, 0, 0
    for target > 0 {
        cur := target % x
        target /= x
        if k > 0 {
            pos, neg = min(cur*k+pos, (cur+1)*k+neg), min((x-cur)*k+pos, (x-cur-1)*k+neg)
        } else {
            pos, neg = cur*2, (x-cur)*2
        }
        k++
    }
    return min(pos, k+neg) - 1
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}