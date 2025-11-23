package main

func minNumberofHosts(rooms []int) int {
    if len(rooms) == 0 {
        return 0
    }
    sort.Ints(rooms)
    res := 1
    for i := 1; i < len(rooms); i++ {
        if rooms[i] <= rooms[i-1] {
            res++
        } else {
            res = 1
        }
    }
    return res
}