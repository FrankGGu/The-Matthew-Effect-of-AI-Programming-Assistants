package main

import (
    "sort"
)

func maximumUnits(boxes [][]int, truckSize int) int {
    sort.Slice(boxes, func(i, j int) bool {
        return boxes[i][1] > boxes[j][1]
    })

    units := 0
    for _, box := range boxes {
        if truckSize <= 0 {
            break
        }
        count := min(box[0], truckSize)
        units += count * box[1]
        truckSize -= count
    }
    return units
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}