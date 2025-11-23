package main

func maximumUnits(boxTypes [][]int, truckSize int) int {
    sort.Slice(boxTypes, func(i, j int) bool {
        return boxTypes[i][1] > boxTypes[j][1]
    })

    units := 0
    for _, box := range boxTypes {
        count := box[0]
        unitPerBox := box[1]
        if truckSize <= 0 {
            break
        }
        take := min(count, truckSize)
        units += take * unitPerBox
        truckSize -= take
    }
    return units
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}