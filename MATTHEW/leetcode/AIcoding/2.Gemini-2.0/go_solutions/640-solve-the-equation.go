import (
	"fmt"
	"strconv"
	"strings"
)

func solveEquation(equation string) string {
	sides := strings.Split(equation, "=")
	left := sides[0]
	right := sides[1]

	leftX, leftNum := parseSide(left)
	rightX, rightNum := parseSide(right)

	totalX := leftX - rightX
	totalNum := rightNum - leftNum

	if totalX == 0 {
		if totalNum == 0 {
			return "Infinite solutions"
		} else {
			return "No solution"
		}
	}

	x := totalNum / totalX
	return "x=" + strconv.Itoa(x)
}

func parseSide(side string) (int, int) {
	xSum := 0
	numSum := 0

	terms := strings.ReplaceAll(side, "+", " ")
	terms = strings.ReplaceAll(terms, "-", " -")
	termsArr := strings.Split(terms, " ")

	for _, term := range termsArr {
		if term == "" {
			continue
		}
		if term == "x" {
			xSum += 1
		} else if term == "-x" {
			xSum -= 1
		} else if strings.Contains(term, "x") {
			numStr := term[:len(term)-1]
			num, _ := strconv.Atoi(numStr)
			xSum += num
		} else {
			num, _ := strconv.Atoi(term)
			numSum += num
		}
	}

	return xSum, numSum
}