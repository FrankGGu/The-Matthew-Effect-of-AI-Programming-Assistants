import "fmt"

const MOD = 1_000_000_007

var (
	fact     []int
	invFact  []int
	adj      [][]int
	dp       []int
	subtreeSize []int
)

func power