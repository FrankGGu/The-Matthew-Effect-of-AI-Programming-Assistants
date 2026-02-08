func findLonely(nums []int) []int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    var lonely []int
    for num, cnt := range count {
        if cnt == 1 && count[num-1] == 0 && count[num+1] == 0 {
            lonely = append(lonely, num)
        }
    }

    return lonely
}