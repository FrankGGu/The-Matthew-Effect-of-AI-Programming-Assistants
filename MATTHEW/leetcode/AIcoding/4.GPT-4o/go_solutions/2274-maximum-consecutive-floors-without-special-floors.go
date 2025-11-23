func maxConsecutive(floors []int, specialFloors []int) int {
    sort.Ints(specialFloors)
    maxCount := 0
    currentCount := 0
    currentFloor := 0

    for _, floor := range floors {
        if currentFloor < floor {
            currentCount++
        } else if currentFloor == floor {
            currentCount = 0
        }

        currentFloor = floor

        if len(specialFloors) > 0 && specialFloors[0] == currentFloor {
            maxCount = max(maxCount, currentCount)
            currentCount = 0
            specialFloors = specialFloors[1:]
        }
    }

    return max(maxCount, currentCount)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}