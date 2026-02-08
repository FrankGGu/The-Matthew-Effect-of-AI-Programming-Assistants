func haveConflict(event1 []string, event2 []string) bool {
    start1, end1 := event1[0], event1[1]
    start2, end2 := event2[0], event2[1]

    return !(end1 < start2 || end2 < start1)
}