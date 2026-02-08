func squareIsWhite(coordinates string) bool {
	col := int(coordinates[0] - 'a')
	row := int(coordinates[1] - '1')
	return (col+row)%2 != 0
}