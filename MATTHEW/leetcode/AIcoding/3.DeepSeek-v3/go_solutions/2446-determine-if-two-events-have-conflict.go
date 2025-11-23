func haveConflict(event1 []string, event2 []string) bool {
    start1 := event1[0]
    end1 := event1[1]
    start2 := event2[0]
    end2 := event2[1]

    if start1 <= end2 && start2 <= end1 {
        return true
    }
    return false
}