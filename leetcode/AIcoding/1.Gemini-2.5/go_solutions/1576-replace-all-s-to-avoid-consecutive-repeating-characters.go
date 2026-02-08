func modifyString(s string) string {
	n := len(s)
	b := []byte(s)

	for i := 0; i < n; i++ {
		if b[i] == '?' {
			for charToTry := byte('a'); charToTry <= 'c'; charToTry++ {
				isValid := true

				// Check left neighbor
				if i > 0 && b[i-1] == charToTry {
					isValid = false
				}

				// Check right neighbor
				// If b[i+1] is '?', it means it's not yet determined,
				// so it doesn't impose a restriction on b[i] at this point.
				// The condition `b[i+1] == charToTry` will be false if b[i+1] is '?',
				// because charToTry is 'a', 'b', or 'c'. This is the desired behavior.
				if i < n-1 && b[i+1] == charToTry {
					isValid = false
				}

				if isValid {
					b[i] = charToTry
					break
				}
			}
		}
	}

	return string(b)
}