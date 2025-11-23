type Segment struct {
	Left  int
	Right int // Exclusive right boundary
}

type BlockPlacementQueries struct {
	maxOccupied int
	gaps        []Segment // Stores empty segments where blocks can potentially be