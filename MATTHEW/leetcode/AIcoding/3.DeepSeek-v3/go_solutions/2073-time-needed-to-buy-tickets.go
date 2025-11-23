func timeRequiredToBuy(tickets []int, k int) int {
    time := 0
    for {
        for i := 0; i < len(tickets); i++ {
            if tickets[i] > 0 {
                tickets[i]--
                time++
                if i == k && tickets[i] == 0 {
                    return time
                }
            }
        }
    }
}