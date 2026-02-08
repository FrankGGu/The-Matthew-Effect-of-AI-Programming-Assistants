type Point struct {
	x, y int
}

type Node struct {
	Cost  int
	Index int
}

type PriorityQueue []Node