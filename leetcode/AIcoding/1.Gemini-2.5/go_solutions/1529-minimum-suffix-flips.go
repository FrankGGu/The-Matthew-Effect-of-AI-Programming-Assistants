func minFlips(target string) int {
	flips := 0
	currentState := byte('0')

	for i := 0; i < len(target); i++ {
		if target[i] != currentState {
			flips++
			// Flip the currentState for subsequent characters
			if currentState == '0' {
				currentState = '1'
			} else {
				currentState = '0'
			}
		}
	}
	return flips
}