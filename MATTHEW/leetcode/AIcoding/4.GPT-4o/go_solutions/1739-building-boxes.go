func canBuildBoxes(boxes []int, units int) bool {
    totalBoxes := 0
    for _, box := range boxes {
        totalBoxes += box
    }
    return totalBoxes <= units
}

func buildBoxes(boxes []int, units int) int {
    totalBoxes := 0
    for _, box := range boxes {
        if units >= box {
            totalBoxes += box
            units -= box
        } else {
            totalBoxes += units
            break
        }
    }
    return totalBoxes
}

func buildingBoxes(boxes []int, units int) int {
    if !canBuildBoxes(boxes, units) {
        return 0
    }
    return buildBoxes(boxes, units)
}