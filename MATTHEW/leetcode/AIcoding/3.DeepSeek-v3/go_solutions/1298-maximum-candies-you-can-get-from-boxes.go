func maxCandies(status []int, candies []int, keys [][]int, containedBoxes [][]int, initialBoxes []int) int {
    n := len(status)
    hasBox := make([]bool, n)
    hasKey := make([]bool, n)
    opened := make([]bool, n)
    queue := make([]int, 0)
    total := 0

    for _, box := range initialBoxes {
        hasBox[box] = true
        if status[box] == 1 {
            opened[box] = true
            queue = append(queue, box)
        }
    }

    for len(queue) > 0 {
        box := queue[0]
        queue = queue[1:]
        total += candies[box]

        for _, key := range keys[box] {
            hasKey[key] = true
            if hasBox[key] && !opened[key] {
                opened[key] = true
                queue = append(queue, key)
            }
        }

        for _, containedBox := range containedBoxes[box] {
            hasBox[containedBox] = true
            if (status[containedBox] == 1 || hasKey[containedBox]) && !opened[containedBox] {
                opened[containedBox] = true
                queue = append(queue, containedBox)
            }
        }
    }

    return total
}