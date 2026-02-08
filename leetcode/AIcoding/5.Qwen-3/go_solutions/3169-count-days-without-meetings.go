package main

func countDaysWithoutMeetings(rooms []int) int {
    if len(rooms) == 0 {
        return 0
    }
    days := make(map[int]bool)
    for _, room := range rooms {
        if room > 0 {
            days[room] = true
        }
    }
    return len(days)
}