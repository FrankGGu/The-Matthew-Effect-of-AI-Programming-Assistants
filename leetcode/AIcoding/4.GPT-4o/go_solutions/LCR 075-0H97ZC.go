func relativeSortArray(arr1 []int, arr2 []int) []int {
    count := make(map[int]int)
    for _, num := range arr1 {
        count[num]++
    }

    result := []int{}
    for _, num := range arr2 {
        if c, ok := count[num]; ok {
            for i := 0; i < c; i++ {
                result = append(result, num)
            }
            delete(count, num)
        }
    }

    remaining := []int{}
    for num, c := range count {
        for i := 0; i < c; i++ {
            remaining = append(remaining, num)
        }
    }
    sort.Ints(remaining)
    result = append(result, remaining...)

    return result
}