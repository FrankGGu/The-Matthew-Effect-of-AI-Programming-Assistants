func divideArray(nums []int) bool {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    for _, c := range count {
        if c % 2 != 0 {
            return false
        }
    }

    return true
}