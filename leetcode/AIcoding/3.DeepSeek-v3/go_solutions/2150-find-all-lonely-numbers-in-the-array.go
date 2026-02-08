func findLonely(nums []int) []int {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }
    var result []int
    for _, num := range nums {
        if freq[num] == 1 && freq[num-1] == 0 && freq[num+1] == 0 {
            result = append(result, num)
        }
    }
    return result
}