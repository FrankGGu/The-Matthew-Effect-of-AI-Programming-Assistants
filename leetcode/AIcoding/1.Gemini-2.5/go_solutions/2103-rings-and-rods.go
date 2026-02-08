func countPoints(rings string) int {
    rodColors := [10]int{} // Using int as a bitmask for colors on each rod

    for i := 0; i < len(rings); i += 2 {
        colorChar := rings[i]
        rodChar := rings[i+1]

        rodIndex := int(rodChar - '0')

        var colorMask int
        if colorChar == 'R' {
            colorMask = 1 // 001
        } else if colorChar == 'G' {
            colorMask = 2 // 010
        } else { // colorChar == 'B'
            colorMask = 4 // 100
        }

        rodColors[rodIndex] |= colorMask
    }

    count := 0
    targetMask := 1 | 2 | 4 // 7 (001 | 010 | 100 = 111) for R, G, B all present

    for i := 0; i < 10; i++ {
        if rodColors[i] == targetMask {
            count++
        }
    }

    return count
}