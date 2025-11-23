import (
	"strings"
)

func alphabetBoardPath(target string) string {
	var result strings.Builder
	currentR, currentC := 0, 0 // Start at 'a' (0,0)

	for _, char := range target {
		targetR, targetC := 0, 0
		if char == 'z' {
			targetR = 5
			targetC = 0
		} else {
			val := int(char - 'a')
			targetR = val / 5
			targetC = val % 5
		}

		dr := targetR - currentR
		dc := targetC - currentC

		// Special handling for 'z' to avoid going out of bounds
		// If moving TO 'z', move horizontally first then vertically.
		// This prevents moving down from (4,X) to (5,X) where X != 0, as (5,X) for X!=0 is not on the board.
		if char == 'z' {
			// Move horizontally
			if dc < 0 {
				for i := 0; i < -dc; i++ {
					result.WriteByte('L')
				}
			} else { // dc >= 0
				for i := 0; i < dc; i++ {
					result.WriteByte('R')
				}
			}
			// Move vertically
			if dr < 0 {
				for i := 0; i < -dr; i++ {
					result.WriteByte('U')
				}
			} else { // dr >= 0
				for i := 0; i < dr; i++ {
					result.WriteByte('D')
				}
			}
		} else if currentR == 5 && currentC == 0 { // If moving FROM 'z'
			// Move vertically first
			// This prevents moving horizontally from (5,0) to (5,X) where X != 0, as (5,X) for X!=0 is not on the board.
			if dr < 0 {
				for i := 0; i < -dr; i++ {
					result.WriteByte('U')
				}
			} else { // dr >= 0
				for i := 0; i < dr; i++ {
					result.WriteByte('D')
				}
			}
			// Move horizontally
			if dc < 0 {
				for i := 0; i < -dc; i++ {
					result.WriteByte('L')
				}
			} else { // dc >= 0
				for i := 0; i < dc; i++ {
					result.WriteByte('R')
				}
			}
		} else { // General case: neither current nor target is 'z' (or both are 'z', which means staying put)
			// Vertical then Horizontal is a safe and consistent order for general cases.
			if dr < 0 {
				for i := 0; i < -dr; i++ {
					result.WriteByte('U')
				}
			} else { // dr >= 0
				for i := 0; i < dr; i++ {
					result.WriteByte('D')
				}
			}
			if dc < 0 {
				for i := 0; i < -dc; i++ {
					result.WriteByte('L')
				}
			} else { // dc >= 0
				for i := 0; i < dc; i++ {
					result.WriteByte('R')
				}
			}
		}

		result.WriteByte('!') // Press '!' for the current character
		currentR = targetR
		currentC = targetC
	}

	return result.String()
}