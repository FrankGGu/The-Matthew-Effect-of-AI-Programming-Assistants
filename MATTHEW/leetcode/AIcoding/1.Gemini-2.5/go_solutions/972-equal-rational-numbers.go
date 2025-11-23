package main

import (
	"math/big"
	"strconv"
	"strings"
)

type Rational struct {
	Num *big.Int
	Den *big.Int
}

func NewRationalBig(num, den *big.Int) *Rational {
	r := &Rational{
		Num: new(big.Int).Set(num),
		Den: new(big.Int).Set(den),
	}
	r.simplify()
	return r
}

func (r *Rational) simplify() {
	if r.Den.Cmp(big.NewInt(0)) == 0 {
		// This should not happen with valid inputs as per problem constraints
		// For safety, panic or handle appropriately.
		// For LeetCode, assuming valid inputs.
		return
	}
	if r.Num.Cmp(big.NewInt(0)) == 0 {
		r.Den.SetInt64(1) // 0/X = 0/1
		return
	}

	gcdVal := new(big.Int).GCD(nil, nil, r.Num, r.Den)
	r.Num.Div(r.Num, gcdVal)
	r.Den.Div(r.Den, gcdVal)

	// Ensure denominator is positive
	if r.Den.Cmp(big.NewInt(0)) < 0 {
		r.Num.Neg(r.Num)
		r.Den.Neg(r.Den)
	}
}

func (r1 *Rational) Add(r2 *Rational) *Rational {
	newNum := new(big.Int).Add(
		new(big.Int).Mul(r1.Num, r2.Den),
		new(big.Int).Mul(r2.Num, r1.Den),
	)
	newDen := new(big.Int).Mul(r1.Den, r2.Den)
	return NewRationalBig(newNum, newDen)
}

func parseRationalToFraction(s string) *Rational {
	dotIdx := strings.Index(s, ".")
	parenIdx := strings.Index(s, "(")

	var integerPartStr string
	var nonRepeatingPartStr string
	var repeatingPartStr string

	if dotIdx == -1 { // No decimal point, only integer part
		integerPartStr = s
	} else {
		integerPartStr = s[:dotIdx]
		if parenIdx == -1 { // No repeating part, only integer and non-repeating decimal
			nonRepeatingPartStr = s[dotIdx+1:]
		} else { // Integer, non-repeating, and repeating parts
			nonRepeatingPartStr = s[dotIdx+1 : parenIdx]
			repeatingPartStr = s[parenIdx+1 : len(s)-1] // Exclude '(' and ')'
		}
	}

	// Initialize with integer part
	integerNum := new(big.Int)
	if integerPartStr == "" { // Handle cases like ".5" or ".(9)" where integer part is implicitly 0
		integerNum.SetInt64(0)
	} else {
		integerNum, _ = integerNum.SetString(integerPartStr, 10)
	}
	currentRational := NewRationalBig(integerNum, big.NewInt(1))

	// Add non-repeating decimal part
	if len(nonRepeatingPartStr) > 0 {
		nonRepeatingNum := new(big.Int)
		nonRepeatingNum, _ = nonRepeatingNum.SetString(nonRepeatingPartStr, 10)

		pow10LenN := new(big.Int).Exp(big.NewInt(10), big.NewInt(int64(len(nonRepeatingPartStr))), nil)
		currentRational = currentRational.Add(NewRationalBig(nonRepeatingNum, pow10LenN))
	}

	// Add repeating decimal part
	if len(repeatingPartStr) > 0 {
		repeatingNum := new(big.Int)
		repeatingNum, _ = repeatingNum.SetString(repeatingPartStr, 10)

		pow10LenN := new(big.Int).Exp(big.NewInt(10), big.NewInt(int64(len(nonRepeatingPartStr))), nil)
		pow10LenR := new(big.Int).Exp(big.NewInt(10), big.NewInt(int64(len(repeatingPartStr))), nil)

		// Denominator for repeating part: 10^len(N) * (10^len(R) - 1)
		term2 := new(big.Int).Sub(pow10LenR, big.NewInt(1)) // 10^len(R) - 1
		denRepeating := new(big.Int).Mul(pow10LenN, term2)

		currentRational = currentRational.Add(NewRationalBig(repeatingNum, denRepeating))
	}

	return currentRational
}

func isRationalEqual(s string, t string) bool {
	valS := parseRationalToFraction(s)
	valT := parseRationalToFraction(t)

	// Compare simplified fractions
	return valS.Num.Cmp(valT.Num) == 0 && valS.Den.Cmp(valT.Den) == 0
}