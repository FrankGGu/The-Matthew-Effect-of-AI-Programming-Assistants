package main

func maxCandies(boxes []int, keys map[int][]int, containedBoxes []int, initialBoxes []int) int {
    visited := make(map[int]bool)
    haveKey := make(map[int]bool)
    for _, box := range initialBoxes {
        visited[box] = true
    }
    for k := range keys {
        haveKey[k] = true
    }
    queue := make([]int, 0)
    for _, box := range initialBoxes {
        queue = append(queue, box)
    }
    result := 0
    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]
        result += boxes[current]
        for _, key := range keys[current] {
            haveKey[key] = true
        }
        for _, box := range containedBoxes {
            if box == current {
                for _, b := range containedBoxes {
                    if !visited[b] {
                        visited[b] = true
                        queue = append(queue, b)
                    }
                }
            }
        }
        for _, b := range containedBoxes {
            if b == current {
                for _, next := range containedBoxes {
                    if !visited[next] && haveKey[next] {
                        visited[next] = true
                        queue = append(queue, next)
                    }
                }
            }
        }
    }
    return result
}