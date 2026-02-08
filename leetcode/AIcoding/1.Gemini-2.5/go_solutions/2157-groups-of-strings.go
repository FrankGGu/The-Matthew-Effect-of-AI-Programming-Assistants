import "fmt"

type DSU struct {
	parent []int
	size   []int
	count  int // Number of disjoint sets
	maxSize int // Size of the largest set
}

func NewDSU(n int