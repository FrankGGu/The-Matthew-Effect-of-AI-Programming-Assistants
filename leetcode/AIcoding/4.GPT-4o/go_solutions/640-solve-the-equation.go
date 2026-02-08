package main

import (
	"fmt"
	"regexp"
	"strconv"
	"strings"
)

func solveEquation(equation string) string {
	parts := strings.Split(equation, "=")
	left, right := parts[0], parts[1]

	leftTerms := parseTerms(left)
	rightTerms := parseTerms(right)

	for k, v := range rightTerms {
		leftTerms[k] -= v
	}

	xCount, num := 0, 0
	for k, v := range leftTerms {
		if k == "" {
			num += v
		} else {
			xCount += v
		}
	}

	if xCount == 0 {
		if num == 0 {
			return "Infinite solutions"
		}
		return "No solution"
	}

	return fmt.Sprintf("x=%d", -num/xCount)
}

func parseTerms(s string) map[string]int {
	terms := make(map[string]int)
	re := regexp.MustCompile(`([+-]?\d*)(x?)`)
	matches := re.FindAllStringSubmatch(s, -1)
	for _, match := range matches {
		if len(match) < 3 {
			continue
		}
		coefficient := 1
		if match[1] != "" && match[1] != "+" && match[1] != "-" {
			coefficient, _ = strconv.Atoi(match[1])
		} else if match[1] == "-" {
			coefficient = -1
		} else if match[1] == "+" {
			coefficient = 1
		}
		if match[2] == "x" {
			terms["x"] += coefficient
		} else {
			terms[""] += coefficient
		}
	}
	return terms
}