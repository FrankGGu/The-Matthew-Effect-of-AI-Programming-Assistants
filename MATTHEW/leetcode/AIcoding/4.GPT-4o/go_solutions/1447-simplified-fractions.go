package main

import (
	"fmt"
)

func simplifiedFractions(n int) []string {
	result := []string{}
	for denominator := 2; denominator <= n; denominator++ {
		for numerator := 1; numerator < denominator; numerator++ {
			if gcd(numerator, denominator) == 1 {
				result = append(result, fmt.Sprintf("%d/%d", numerator, denominator))
			}
		}
	}
	return result
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func main() {
	n := 5
	fmt.Println(simplifiedFractions(n))
}