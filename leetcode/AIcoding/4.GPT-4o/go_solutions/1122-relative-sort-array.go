func relativeSortArray(arr1 []int, arr2 []int) []int {
    count := make([]int, 1001)
    for _, num := range arr1 {
        count[num]++
    }

    result := []int{}
    for _, num := range arr2 {
        for count[num] > 0 {
            result = append(result, num)
            count[num]--
        }
    }

    for num := 0; num < 1001; num++ {
        for count[num] > 0 {
            result = append(result, num)
            count[num]--
        }
    }

    return result
}