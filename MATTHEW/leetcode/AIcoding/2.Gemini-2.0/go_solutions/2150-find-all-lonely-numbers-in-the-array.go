func findLonely(nums []int) []int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    result := []int{}
    for num, freq := range count {
        if freq == 1 {
            if _, ok := count[num-1]; !ok {
                if _, ok := count[num+1]; !ok {
                    result = append(result, num)
                }
            }
        }
    }

    return result
}