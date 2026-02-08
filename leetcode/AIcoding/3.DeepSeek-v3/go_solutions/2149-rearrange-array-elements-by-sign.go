func rearrangeArray(nums []int) []int {
    pos, neg := make([]int, 0), make([]int, 0)
    for _, num := range nums {
        if num > 0 {
            pos = append(pos, num)
        } else {
            neg = append(neg, num)
        }
    }
    res := make([]int, 0)
    for i := 0; i < len(pos); i++ {
        res = append(res, pos[i], neg[i])
    }
    return res
}