package main

func calculateScore(operations []string) int {
    score := 0
    for _, op := range operations {
        if op == "X" {
            score += 10
        } else if op == "O" {
            score += 5
        } else if op == "V" {
            score += 1
        }
    }
    return score
}