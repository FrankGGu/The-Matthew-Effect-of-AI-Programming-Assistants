package main

func minWaitingRoomChairs(seients []string) int {
    current := 0
    max := 0
    for _, s := range seients {
        if s == "P" {
            current++
            if current > max {
                max = current
            }
        } else {
            current--
        }
    }
    return max
}