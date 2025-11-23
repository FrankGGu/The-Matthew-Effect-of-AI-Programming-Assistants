package main

func chessboardGame(x int, y int) int {
    if (x+y)%2 == 0 {
        return 1
    }
    return 2
}