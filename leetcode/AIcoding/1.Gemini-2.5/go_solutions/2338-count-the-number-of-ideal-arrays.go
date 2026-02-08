import "fmt"

const MOD = 1e9 + 7

var (
	fact     []int
	invFact  []int
	maxNplusK int
)

func power(base, exp int) int {
	res := 1
	base %= MOD
	for exp > 0 {
		if