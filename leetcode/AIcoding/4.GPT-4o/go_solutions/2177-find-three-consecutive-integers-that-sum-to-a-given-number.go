func sumOfThree(num int) []int {
    if num%3 != 0 {
        return []int{}
    }
    mid := num / 3
    return []int{mid - 1, mid, mid + 1}
}