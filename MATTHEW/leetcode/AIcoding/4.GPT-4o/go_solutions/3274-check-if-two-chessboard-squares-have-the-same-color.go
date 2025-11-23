func squareIsWhite(coordinates string) bool {
    return (coordinates[0]-'a'+coordinates[1]-'1')%2 == 1
}