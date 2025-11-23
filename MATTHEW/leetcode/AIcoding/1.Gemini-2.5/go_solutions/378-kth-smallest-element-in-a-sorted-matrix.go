type IntHeap [][3]int // [value, row, col]

func (h IntHeap) Len() int { return len(h) }
func (h IntHeap) Less(i, j int) bool {