package main

func relativeSort(arr1 []int, arr2 []int) []int {
    indexMap := make(map[int]int)
    for i, num := range arr2 {
        indexMap[num] = i
    }

    sort.Slice(arr1, func(i, j int) bool {
        if idxI, okI := indexMap[arr1[i]]; okI {
            if idxJ, okJ := indexMap[arr1[j]]; okJ {
                return idxI < idxJ
            }
            return true
        }
        if idxJ, okJ := indexMap[arr1[j]]; okJ {
            return false
        }
        return arr1[i] < arr1[j]
    })

    return arr1
}