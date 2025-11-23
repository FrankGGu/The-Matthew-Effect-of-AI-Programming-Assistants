func intersection(arrays [][]int) []int {
    count := make(map[int]int)
    result := []int{}

    for _, array := range arrays {
        unique := make(map[int]bool)
        for _, num := range array {
            unique[num] = true
        }
        for num := range unique {
            count[num]++
        }
    }

    for num, cnt := range count {
        if cnt == len(arrays) {
            result = append(result, num)
        }
    }

    sort.Ints(result)
    return result
}