func sumOfUnique(nums []int) int {
    count := make(map[int]int)
    sum := 0
    for _, num := range nums {
        count[num]++
    }
    for num, freq := range count {
        if freq == 1 {
            sum += num
        }
    }
    return sum
}