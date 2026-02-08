package main

func pancakeSorting(arr []int) []int {
    n := len(arr)
    res := []int{}

    for i := n; i > 1; i-- {
        maxIndex := 0
        for j := 0; j < i; j++ {
            if arr[j] > arr[maxIndex] {
                maxIndex = j
            }
        }

        if maxIndex == i-1 {
            continue
        }

        if maxIndex != 0 {
            reverse(arr, 0, maxIndex)
            res = append(res, maxIndex+1)
        }

        reverse(arr, 0, i-1)
        res = append(res, i)
    }

    return res
}

func reverse(arr []int, start, end int) {
    for start < end {
        arr[start], arr[end] = arr[end], arr[start]
        start++
        end--
    }
}