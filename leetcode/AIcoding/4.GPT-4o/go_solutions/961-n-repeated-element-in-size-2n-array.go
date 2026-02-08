func repeatedNTimes(A []int) int {
    count := make(map[int]int)
    for _, num := range A {
        count[num]++
        if count[num] == 2 {
            return num
        }
    }
    return -1
}