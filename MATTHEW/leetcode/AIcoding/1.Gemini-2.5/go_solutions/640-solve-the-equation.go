package main

import (
	"strconv"
	"strings"
)

func parseSide(s string) (xCoeff, constVal int) {
	sign := 1 // sign for the current term
	currentNum := 0
	parsingNum := false

	for i := 0; i < len(s); { // No i++ here, we control i manually
		char := s[i]

		if char >= '0' && char <= '9' {
			currentNum = currentNum*10 + int(char-'0')
			parsingNum = true
			i++
		} else { // char is '+', '-', or 'x'
			if parsingNum { // We just finished parsing a number
				if char == 'x' {
					xCoeff += sign * currentNum
					i++ // Consume 'x'
				} else { // It's a constant
					constVal += sign * currentNum
				}
				currentNum = 0
				parsingNum = false
			} else if char == 'x' { // Case like "x", "+x", "-x" where no explicit number is given
				xCoeff += sign * 1
				i++ // Consume 'x'
			}

			if char == '+' {
				sign = 1
				i++
			} else if char == '-' {
				sign = -1
				i++
			}
		}
	}

	// Handle the last term if it was a number
	if parsingNum {
		constVal += sign * currentNum
	}
	return xCoeff, constVal
}

func solveEquation(equation string) string {
	parts := strings.Split(equation, "=")
	leftSide := parts[0]
	rightSide := parts[1]

	lx, lc := parseSide(leftSide)
	rx, rc := parseSide(rightSide)

	// Equation: lx * x + lc = rx * x + rc
	// Rearrange: (lx - rx) * x = rc - lc
	coeffX := lx - rx
	constVal := rc - lc

	if coeffX == 0 {
		if constVal == 0 {
			return "Infinite solutions"
		} else {
			return "No solution"
		}
	} else {
		return "x=" + strconv.Itoa(constVal/coeffX)
	}
}