func latestTimeCatchTheBus(buses []int, passengers []int, capacity int) int {
    sort.Ints(buses)
    sort.Ints(passengers)

    res := 0
    j := 0
    for i := 0; i < len(buses); i++ {
        cnt := 0
        for j < len(passengers) && passengers[j] <= buses[i] && cnt < capacity {
            if j == 0 || passengers[j-1] != passengers[j]-1 {
                res = passengers[j] - 1
            }
            j++
            cnt++
        }
        if cnt < capacity && (j == 0 || passengers[j-1] != buses[i]) {
            res = buses[i]
        }
    }
    return res
}