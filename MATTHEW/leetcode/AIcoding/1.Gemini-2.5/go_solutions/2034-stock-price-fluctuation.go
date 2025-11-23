type PriceEntry struct {
	price     int
	timestamp int
}

type maxHeap []PriceEntry

func (h maxHeap) Len() int           {