import "math/rand"

type Solution struct {
	m, n    int
	total   int // total number of cells m * n
	size    int // current number of available (0) cells
	valMap  map[int]int // maps a logical index to an actual cell index
	r       *rand.Rand
}