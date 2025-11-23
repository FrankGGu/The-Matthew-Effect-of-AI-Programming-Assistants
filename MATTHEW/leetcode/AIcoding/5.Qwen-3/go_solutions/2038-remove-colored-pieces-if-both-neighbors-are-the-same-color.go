package main

func winnerOfGame(colors string) string {
    count := 0
    for i := 1; i < len(colors)-1; i++ {
        if colors[i-1] == colors[i] && colors[i] == colors[i+1] {
            count++
        }
    }
    if count > 0 {
        return "A"
    }
    return "B"
}