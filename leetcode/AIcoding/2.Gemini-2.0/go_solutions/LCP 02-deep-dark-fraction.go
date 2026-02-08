import (
	"fmt"
	"math"
)

func fraction(cont []int) []int {
	n := len(cont)
	if n == 1 {
		return []int{cont[0], 1}
	}

	a := cont[n-1]
	b := 1

	for i := n - 2; i >= 0; i-- {
		a, b = cont[i]*a+b, a
	}

	gcd := func(a, b int) int {
		for b != 0 {
			a, b = b, a%b
		}
		return a
	}

	common := gcd(a, b)
	return []int{a / common, b / common}
}