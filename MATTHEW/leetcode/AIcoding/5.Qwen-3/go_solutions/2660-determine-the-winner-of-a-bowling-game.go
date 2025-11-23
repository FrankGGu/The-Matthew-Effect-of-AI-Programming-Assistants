package main

func isWinner(plate1 []int, plate2 []int) bool {
    score1 := 0
    score2 := 0
    for i := 0; i < len(plate1); i++ {
        score1 += plate1[i]
        score2 += plate2[i]
    }
    return score1 > score2
}