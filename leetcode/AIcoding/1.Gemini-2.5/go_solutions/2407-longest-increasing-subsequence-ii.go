import "math"

const MAX_VAL = 100000

type SegmentTree struct {
	tree []int // Stores the maximum value in each segment