func placeWordInCrossword(board [][]byte, word string) bool {
	m, n := len(board), len(board[0])
	wordLen := len(word)

	var checkHorizontal func(row int, forward bool) bool
	checkHorizontal = func(row int, forward bool) bool {
		for start := 0; start < n; start++ {
			if board[row][start] != ' ' {
				continue
			}

			count := 0
			for end := start; end < n; end++ {
				if board[row][end] != ' ' && board[row][end] != word[count] {
					break
				}
				if board[row][end] == ' ' || board[row][end] == word[count] {
					count++
					if count == wordLen {
						if end+1 == n || board[row][end+1] == '#' {
							if start == 0 || board[row][start-1] == '#' {

								valid := true

								if forward {
									for k := 0; k < wordLen; k++ {
										if board[row][start+k] != ' ' && board[row][start+k] != word[k] {
											valid = false
											break
										}
									}
								} else {
									for k := 0; k < wordLen; k++ {
										if board[row][start+k] != ' ' && board[row][start+k] != word[wordLen-1-k] {
											valid = false
											break
										}
									}
								}

								if valid {
									return true
								}
							}
						}
						break
					}
				} else {
					break
				}
			}
		}
		return false
	}

	var checkVertical func(col int, forward bool) bool
	checkVertical = func(col int, forward bool) bool {
		for start := 0; start < m; start++ {
			if board[start][col] != ' ' {
				continue
			}

			count := 0
			for end := start; end < m; end++ {
				if board[end][col] != ' ' && board[end][col] != word[count] {
					break
				}
				if board[end][col] == ' ' || board[end][col] == word[count] {
					count++
					if count == wordLen {
						if end+1 == m || board[end+1][col] == '#' {
							if start == 0 || board[start-1][col] == '#' {

								valid := true

								if forward {
									for k := 0; k < wordLen; k++ {
										if board[start+k][col] != ' ' && board[start+k][col] != word[k] {
											valid = false
											break
										}
									}
								} else {
									for k := 0; k < wordLen; k++ {
										if board[start+k][col] != ' ' && board[start+k][col] != word[wordLen-1-k] {
											valid = false
											break
										}
									}
								}

								if valid {
									return true
								}
							}
						}
						break
					}
				} else {
					break
				}
			}
		}
		return false
	}

	for i := 0; i < m; i++ {
		if checkHorizontal(i, true) {
			return true
		}
		reversedWord := ""
		for j := len(word) - 1; j >= 0; j-- {
			reversedWord += string(word[j])
		}

		if checkHorizontal(i, false) {
			return true
		}
	}

	for i := 0; i < n; i++ {
		if checkVertical(i, true) {
			return true
		}
		if checkVertical(i, false) {
			return true
		}
	}

	return false
}