func findClosestPerson(people []int, target int) int {
    closest := -1
    minDiff := int(^uint(0) >> 1)

    for _, person := range people {
        diff := abs(person - target)
        if diff < minDiff {
            minDiff = diff
            closest = person
        }
    }
    return closest
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}