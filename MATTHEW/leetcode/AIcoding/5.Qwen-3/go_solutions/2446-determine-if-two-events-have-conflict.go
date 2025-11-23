package main

func haveConflict(event1 []string, event2 []string) bool {
    start1, end1 := event1[0], event1[1]
    start2, end2 := event2[0], event2[1]

    return compareTime(start1, start2) <= 0 && compareTime(end1, start2) >= 0
}

func compareTime(t1, t2 string) int {
    h1, _ := strconv.Atoi(t1[:2])
    m1, _ := strconv.Atoi(t1[3:])
    h2, _ := strconv.Atoi(t2[:2])
    m2, _ := strconv.Atoi(t2[3:])

    time1 := h1*60 + m1
    time2 := h2*60 + m2

    if time1 < time2 {
        return -1
    } else if time1 > time2 {
        return 1
    }
    return 0
}