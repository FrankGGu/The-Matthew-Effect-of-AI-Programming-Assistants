package main

func countPoints(rings string) int {
    color := [3]int{}
    for i := 0; i < len(rings); i += 2 {
        pos := int(rings[i] - '0')
        if rings[i+1] == 'R' {
            color[0] |= 1 << pos
        } else if rings[i+1] == 'G' {
            color[1] |= 1 << pos
        } else {
            color[2] |= 1 << pos
        }
    }
    count := 0
    for i := 0; i < 3; i++ {
        if color[i] == 0x1FF {
            count++
        }
    }
    return count
}