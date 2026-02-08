func minWastedSpace(packages []int, boxes [][]int) int {
    sort.Ints(packages)
    total := 0
    for _, p := range packages {
        total += p
    }

    minWasted := math.MaxInt32
    for _, box := range boxes {
        sort.Ints(box)
        if box[len(box)-1] < packages[len(packages)-1] {
            continue
        }

        wasted := 0
        j := 0
        for _, b := range box {
            currentWasted := b
            for j < len(packages) && packages[j] <= b {
                currentWasted -= packages[j]
                j++
            }
            wasted += currentWasted
        }

        minWasted = min(minWasted, wasted)
    }

    if minWasted == math.MaxInt32 {
        return 0
    }
    return minWasted
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}