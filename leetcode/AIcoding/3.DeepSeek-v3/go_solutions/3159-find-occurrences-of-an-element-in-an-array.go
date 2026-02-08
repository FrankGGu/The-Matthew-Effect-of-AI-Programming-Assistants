func occurrencesOfElement(nums []int, queries []int, x int) []int {
    indices := []int{}
    for i, num := range nums {
        if num == x {
            indices = append(indices, i)
        }
    }
    res := make([]int, len(queries))
    for i, q := range queries {
        if q > len(indices) {
            res[i] = -1
        } else {
            res[i] = indices[q-1]
        }
    }
    return res
}