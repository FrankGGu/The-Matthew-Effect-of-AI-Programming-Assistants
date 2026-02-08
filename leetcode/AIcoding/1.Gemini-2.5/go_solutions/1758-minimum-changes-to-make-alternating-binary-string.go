package main

import "math"

func minOperations(s string) int {
	changes0 := 0 // Count changes if the target alternating string starts with '0' (e.g., "01010")
	changes1 := 0 // Count changes if the target alternating string starts with '1' (e.g., "10101")

	for i, char := range s {
		if i%2 == 0 { // Even index
			// If target starts with '0', this position should be '0'
			if char == '1' {
				changes0++
			}
			// If target starts with '1', this position should be '1'
			if char == '0' {
				changes1++
			}
		} else { // Odd index
			// If target starts with '0', this position should be '1'
			if char == '0' {
				changes0++
			}
			// If target starts with '1', this position should be '0'
			if char == '1' {
				changes1++
			}
		}
	}

	return int(math.Min(float64(changes0), float64(changes1)))
}