func fileCombination(target int) [][]int {
    var res [][]int
    left, right := 1, 1
    sum := 0
    for left <= target/2 {
        if sum < target {
            sum += right
            right++
        } else if sum > target {
            sum -= left
            left++
        } else {
            tmp := make([]int, 0)
            for i := left; i < right; i++ {
                tmp = append(tmp, i)
            }
            res = append(res, tmp)
            sum -= left
            left++
        }
    }
    return res
}