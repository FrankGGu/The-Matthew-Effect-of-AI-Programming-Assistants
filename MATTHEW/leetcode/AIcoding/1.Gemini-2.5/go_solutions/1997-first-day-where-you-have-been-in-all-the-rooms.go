func firstDayBeenAllRooms(nextVisit []int) int {
    n := len(nextVisit)
    mod := 1_000_000_007

    // dp[i] represents the number of days passed until we have visited room 'i'
    // an even number of times for the first time, and