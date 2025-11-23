package main

import (
	"math/big"
	"sort"
	"strings"
)

func countAnagrams(s string) int {
	mod := int(1e9 + 7)
	words := strings.Fields(s)
	fact := make([]*big.Int, len(s)+1)
	fact[0] = big.NewInt(1)
	for i := 1; i <= len(s); i++ {
		fact[i] = new(big.Int).Mul(fact[i-1], big.NewInt(int64(i)))
	}

	result := big.NewInt(1)
	for _, word := range words {
		counts := make(map[rune]int)
		for _, ch := range word {
			counts[ch]++
		}
		denom := big.NewInt(1)
		for _, v := range counts {
			denom.Mul(denom, fact[int(v)])
		}
		result.Mul(result, fact[len(word)])
		result.Div(result, denom)
		result.Mod(result, big.NewInt(int64(mod)))
	}

	return int(result.Int64())
}

func main() {}