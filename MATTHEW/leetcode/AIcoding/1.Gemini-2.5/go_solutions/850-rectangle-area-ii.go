const MOD = 1_000_000_007

type Event struct {
	x    int
	y1   int
	y2   int
	typ  int // 1 for add (left edge), -1 for remove (right edge)
}