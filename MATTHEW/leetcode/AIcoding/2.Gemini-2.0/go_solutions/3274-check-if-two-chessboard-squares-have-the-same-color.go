func squareIsWhite(coordinates string) bool {
	col := int(coordinates[0] - 'a' + 1)
	row := int(coordinates[1] - '0')

	return (col+row)%2 != 0
}