package main

func commonElements(arr1 []int, arr2 []int) []int {
    set := make(map[int]bool)
    result := []int{}

    for _, num := range arr1 {
        set[num] = true
    }

    for _, num := range arr2 {
        if set[num] {
            result = append(result, num)
            set[num] = false // to avoid duplicates
        }
    }

    return result
}