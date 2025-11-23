package main

func isPossibleToCatchApple(height, width int, apples [][]int, moves string) bool {
    dx := []int{-1, 0, 1, 0}
    dy := []int{0, 1, 0, -1}
    x, y := 0, 0
    for i := 0; i < len(moves); i++ {
        switch moves[i] {
        case 'U':
            x -= 1
        case 'D':
            x += 1
        case 'R':
            y += 1
        case 'L':
            y -= 1
        }
        if x < 0 || x >= height || y < 0 || y >= width {
            return false
        }
        for _, apple := range apples {
            if apple[0] == x && apple[1] == y {
                return true
            }
        }
    }
    return false
}