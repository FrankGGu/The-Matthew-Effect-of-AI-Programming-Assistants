func canTransfer(gifts []int, num int) bool {
    sum := 0
    for _, gift := range gifts {
        sum += gift
    }
    if sum%num != 0 {
        return false
    }
    target := sum / num
    return backtrack(gifts, make([]bool, len(gifts)), 0, target, 0, num)
}

func backtrack(gifts []int, used []bool, start int, target int, currentSum int, num int) bool {
    if num == 1 {
        return true
    }
    if currentSum == target {
        return backtrack(gifts, used, 0, target, 0, num-1)
    }
    for i := start; i < len(gifts); i++ {
        if used[i] || currentSum+gifts[i] > target {
            continue
        }
        used[i] = true
        if backtrack(gifts, used, i+1, target, currentSum+gifts[i], num) {
            return true
        }
        used[i] = false
    }
    return false
}