package main

func 机器人能否返回原点(s string) bool {
    x, y := 0, 0
    for _, c := range s {
        switch c {
        case 'U':
            y++
        case 'D':
            y--
        case 'L':
            x--
        case 'R':
            x++
        }
    }
    return x == 0 && y == 0
}