import (
	"math/big"
)

func numSteps(s string) int {
	n := new(big.Int)
	n.SetString(s, 2)

	one := big.NewInt(1)
	two := big.NewInt(2)
	steps := 0

	for n.Cmp(one) != 0 {
		if n.Bit(0) == 0 {
			n.Div(n, two)
		} else {
			n.Add(n, one)
		}
		steps++
	}

	return steps
}