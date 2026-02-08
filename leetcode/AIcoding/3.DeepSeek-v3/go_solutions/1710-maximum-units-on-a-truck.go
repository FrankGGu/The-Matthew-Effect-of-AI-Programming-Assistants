import "sort"

func maximumUnits(boxTypes [][]int, truckSize int) int {
    sort.Slice(boxTypes, func(i, j int) bool {
        return boxTypes[i][1] > boxTypes[j][1]
    })

    units := 0
    for _, box := range boxTypes {
        if truckSize <= 0 {
            break
        }
        take := box[0]
        if take > truckSize {
            take = truckSize
        }
        units += take * box[1]
        truckSize -= take
    }
    return units
}