package main

import (
	"fmt"
	"math/big"
	"strings"
)

func isRationalEqual(S string, T string) bool {
	return parseRational(S).Cmp(parseRational(T)) == 0
}

func parseRational(s string) *big.Rat {
	if strings.Contains(s, ".") {
		parts := strings.Split(s, ".")
		integral := parts[0]
		decimal := parts[1]
		denom := big.NewInt(int64(1))
		for i := 0; i < len(decimal); i++ {
			denom.Mul(denom, big.NewInt(10))
		}
		numerator := big.NewInt(0)
		numerator.SetString(integral, 10)
		numerator.Mul(numerator, denom)
		for _, char := range decimal {
			numerator.Mul(numerator, big.NewInt(10))
			numerator.Add(numerator, big.NewInt(int64(char-'0')))
		}
		return new(big.Rat).SetFrac(numerator, denom)
	}
	return new(big.Rat).SetString(s)
}

func main() {
	fmt.Println(isRationalEqual("0.1", "0.10")) // Example usage
}