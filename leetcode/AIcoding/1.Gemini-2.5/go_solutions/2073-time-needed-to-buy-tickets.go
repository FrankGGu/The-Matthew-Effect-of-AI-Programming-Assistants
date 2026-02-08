func timeRequiredToBuy(tickets []int, k int) int {
    n := len(tickets)
    time := 0

    for {
        for i := 0; i < n; i++ {
            // If the current person has tickets remaining
            if tickets[i] > 0 {
                tickets[i]-- //