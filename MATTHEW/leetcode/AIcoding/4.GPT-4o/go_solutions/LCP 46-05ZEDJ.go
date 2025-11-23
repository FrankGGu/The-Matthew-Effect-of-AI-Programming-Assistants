func maxVolunteerAssignments(volunteers []int, tasks []int) int {
    sort.Ints(volunteers)
    sort.Ints(tasks)

    vCount, tCount := len(volunteers), len(tasks)
    vIndex, tIndex := 0, 0
    assigned := 0

    for vIndex < vCount && tIndex < tCount {
        if volunteers[vIndex] >= tasks[tIndex] {
            assigned++
            tIndex++
        }
        vIndex++
    }

    return assigned
}