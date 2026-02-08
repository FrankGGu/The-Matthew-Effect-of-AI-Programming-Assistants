package main

func timeRequiredToBuy(tickets []int, k int) int {
    queue := make([]int, len(tickets))
    for i := range tickets {
        queue[i] = tickets[i]
    }
    time := 0
    for {
        for i := 0; i < len(queue); i++ {
            if queue[i] == 0 {
                continue
            }
            queue[i]--
            time++
            if queue[i] == 0 && i == k {
                return time
            }
        }
    }
}