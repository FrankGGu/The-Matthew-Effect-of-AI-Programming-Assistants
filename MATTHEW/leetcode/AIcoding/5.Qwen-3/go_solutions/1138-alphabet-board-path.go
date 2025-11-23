package main

func alphabetBoardPath(target string) string {
    res := ""
    x, y := 0, 0
    for _, c := range target {
        dx, dy := 0, 0
        switch c {
        case 'a':
            dx, dy = 0, 0
        case 'b':
            dx, dy = 1, 0
        case 'c':
            dx, dy = 2, 0
        case 'd':
            dx, dy = 3, 0
        case 'e':
            dx, dy = 4, 0
        case 'f':
            dx, dy = 0, 1
        case 'g':
            dx, dy = 1, 1
        case 'h':
            dx, dy = 2, 1
        case 'i':
            dx, dy = 3, 1
        case 'j':
            dx, dy = 4, 1
        case 'k':
            dx, dy = 5, 1
        case 'l':
            dx, dy = 6, 1
        case 'm':
            dx, dy = 7, 1
        case 'n':
            dx, dy = 8, 1
        case 'o':
            dx, dy = 9, 1
        case 'p':
            dx, dy = 10, 1
        case 'q':
            dx, dy = 0, 2
        case 'r':
            dx, dy = 1, 2
        case 's':
            dx, dy = 2, 2
        case 't':
            dx, dy = 3, 2
        case 'u':
            dx, dy = 4, 2
        case 'v':
            dx, dy = 5, 2
        case 'w':
            dx, dy = 6, 2
        case 'x':
            dx, dy = 7, 2
        case 'y':
            dx, dy = 8, 2
        case 'z':
            dx, dy = 9, 2
        }
        if dx < x {
            for i := 0; i < x-dx; i++ {
                res += "U"
            }
        }
        if dy < y {
            for i := 0; i < y-dy; i++ {
                res += "L"
            }
        }
        if dx > x {
            for i := 0; i < dx-x; i++ {
                res += "D"
            }
        }
        if dy > y {
            for i := 0; i < dy-y; i++ {
                res += "R"
            }
        }
        res += "!"
        x, y = dx, dy
    }
    return res
}