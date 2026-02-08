func minWastedSpace(packages []int, boxes [][]int) int {
    sort.Ints(packages)
    total := 0
    for _, pkg := range packages {
        total += pkg
    }

    minWasted := math.MaxInt32
    for _, box := range boxes {
        sort.Ints(box)
        if box[len(box)-1] < packages[len(packages)-1] {
            continue
        }

        wasted := 0
        j := 0
        for i := 0; i < len(box); i++ {
            cap := box[i]
            sum := 0
            count := 0

            for j < len(packages) && packages[j] <= cap {
                sum += packages[j]
                count++
                j++
            }
            wasted += count*cap - sum
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