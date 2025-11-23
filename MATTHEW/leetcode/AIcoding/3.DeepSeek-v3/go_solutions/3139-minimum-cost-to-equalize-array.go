func minCostToEqualizeArray(nums []int, cost1 int, cost2 int) int {
    const mod = 1e9 + 7
    maxNum := 0
    minNum := nums[0]
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
        if num < minNum {
            minNum = num
        }
    }

    total := 0
    for _, num := range nums {
        total += maxNum - num
    }

    if cost1 * 2 <= cost2 {
        return (total * cost1) % mod
    }

    res := 0
    sum := 0
    for _, num := range nums {
        sum += maxNum - num
    }

    res = (sum / 2) * cost2
    if sum % 2 != 0 {
        res += cost1
    }

    maxNum++
    sum = 0
    for _, num := range nums {
        sum += maxNum - num
    }

    newRes := (sum / 2) * cost2
    if sum % 2 != 0 {
        newRes += cost1
    }

    if newRes < res {
        res = newRes
    }

    return res % mod
}