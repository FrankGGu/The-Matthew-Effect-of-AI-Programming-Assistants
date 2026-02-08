type Pair struct {
	Val   int
	Index int
}

type MinHeap []Pair

func (h MinHeap) Len() int