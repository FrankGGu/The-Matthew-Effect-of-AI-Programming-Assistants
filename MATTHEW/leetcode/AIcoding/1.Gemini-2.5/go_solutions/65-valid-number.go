func isNumber(s string) bool {
	type CharType int
	const (
		CHAR_SPACE CharType = iota
		CHAR_SIGN
		CHAR_DIGIT
		CHAR_DOT
		CHAR_EXPONENT
		CHAR_INVALID
	)

	type State int
	const (
		STATE_INITIAL State = i