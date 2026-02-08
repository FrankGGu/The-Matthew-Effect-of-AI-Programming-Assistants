package main

func relativeSort(arr1 []int, arr2 []int) []int {
    indexMap := make(map[int]int)
    for i, num := range arr2 {
        indexMap[num] = i
    }

    sort.Slice(arr1, func(i, j int) bool {
        idxI, okI := indexMap[arr1[i]]
        idxJ, okJ := indexMap[arr1[j]]
        if okI && okJ {
            return idxI < idxJ
        }
        if okI {
            return true
        }
        if okJ {
            return false
        }
        return arr1[i] < arr1[j]
    })

    return arr1
}