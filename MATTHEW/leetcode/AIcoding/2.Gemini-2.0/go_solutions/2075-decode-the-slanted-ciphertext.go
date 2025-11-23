func decodeCiphertext(encodedText string, rows int) string {
	n := len(encodedText)
	if n == 0 {
		return ""
	}
	cols := n / rows
	if n%rows != 0 {
		return ""
	}

	decodedText := make([]byte, 0, n)
	for i := 0; i < cols; i++ {
		row := 0
		col := i
		for row < rows && col < cols {
			decodedText = append(decodedText, encodedText[row*cols+col])
			row++
			col++
		}
	}

	// Remove trailing spaces
	k := len(decodedText) - 1
	for k >= 0 && decodedText[k] == ' ' {
		k--
	}

	return string(decodedText[:k+1])
}