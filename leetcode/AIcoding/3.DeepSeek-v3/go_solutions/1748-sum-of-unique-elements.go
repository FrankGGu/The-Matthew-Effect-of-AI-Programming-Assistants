func sumOfUnique(nums []int) int {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }
    sum := 0
    for num, count := range freq {
        if count == 1 {
            sum += num
        }
    }
    return sum
}