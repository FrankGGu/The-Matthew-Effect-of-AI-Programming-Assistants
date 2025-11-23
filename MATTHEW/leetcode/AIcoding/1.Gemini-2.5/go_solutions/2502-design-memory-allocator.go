type Allocator struct {
	memory []int
}

func Constructor(n int) Allocator {
	return Allocator{
		memory: make([]int, n),
	}
}

func (this *Allocator) Allocate(size int, mID int) int {
	n := len(this.memory)

	currentConsecutiveZeros := 0
	startIndex := -1

	for i := 0; i < n; i++ {
		if this.memory[i] == 0 {
			if startIndex == -1 {
				startIndex = i
			}
			currentConsecutiveZeros++

			if currentConsecutiveZeros == size {
				for j := startIndex; j < startIndex+size; j++ {
					this.memory[j] = mID
				}
				return startIndex
			}
		} else {
			currentConsecutiveZeros = 0
			startIndex = -1
		}
	}
	return -1
}

func (this *Allocator) Free(mID int) int {
	freedCount := 0
	for i := 0; i < len(this.memory); i++ {
		if this.memory[i] == mID {
			this.memory[i] = 0
			freedCount++
		}
	}
	return freedCount
}