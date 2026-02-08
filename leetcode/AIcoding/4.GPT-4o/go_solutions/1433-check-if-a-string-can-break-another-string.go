package main

import "sort"

func checkIfCanBreak(s1 string, s2 string) bool {
    arr1 := []rune(s1)
    arr2 := []rune(s2)
    sort.Slice(arr1, func(i, j int) bool {
        return arr1[i] < arr1[j]
    })
    sort.Slice(arr2, func(i, j int) bool {
        return arr2[i] < arr2[j]
    })

    canBreak1 := true
    canBreak2 := true

    for i := 0; i < len(arr1); i++ {
        if arr1[i] < arr2[i] {
            canBreak1 = false
        }
        if arr1[i] > arr2[i] {
            canBreak2 = false
        }
    }

    return canBreak1 || canBreak2
}