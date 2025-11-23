type NumberContainers struct {
	numMap  map[int]int
	indexMap map[int][]int
}

func Constructor() NumberContainers {
	return NumberContainers{
		numMap:  make(map[int]int),
		indexMap: make(map[int][]int),
	}
}

func (this *NumberContainers) Change(index int, number int) {
	this.numMap[index] = number
	this.indexMap[number] = append(this.indexMap[number], index)
}

func (this *NumberContainers) Find(number int) int {
	indices := this.indexMap[number]
	if len(indices) == 0 {
		return -1
	}

	min := -1
	for _, index := range indices {
		if this.numMap[index] == number {
			if min == -1 || index < min {
				min = index
			}
		}
	}

	if min == -1 {
		this.indexMap[number] = []int{}
		return -1
	}

	return min
}