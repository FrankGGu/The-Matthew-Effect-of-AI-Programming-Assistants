func pivotArray(nums []int, pivot int) []int {
    less, equal, greater := []int{}, []int{}, []int{}
    for _, num := range nums {
        if num < pivot {
            less = append(less, num)
        } else if num == pivot {
            equal = append(equal, num)
        } else {
            greater = append(greater, num)
        }
    }
    return append(append(less, equal...), greater...)
}