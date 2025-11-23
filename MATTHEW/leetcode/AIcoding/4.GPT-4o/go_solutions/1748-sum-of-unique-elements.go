func sumOfUnique(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }
    sum := 0
    for num, c := range count {
        if c == 1 {
            sum += num
        }
    }
    return sum
}