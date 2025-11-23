type Item struct {
	count int
	char  rune
}

type MaxHeap []*Item

func (h MaxHeap) Len() int           { return