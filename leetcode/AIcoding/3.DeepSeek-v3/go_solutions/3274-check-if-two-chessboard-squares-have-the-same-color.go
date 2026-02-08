func squareIsWhite(coordinates string) bool {
    x := coordinates[0] - 'a'
    y := coordinates[1] - '1'
    return (x + y) % 2 != 0
}