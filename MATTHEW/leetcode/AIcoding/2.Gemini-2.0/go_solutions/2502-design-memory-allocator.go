type Allocator struct {
	mem   []int
	sizes map[int]int
	starts map[int]int
}

func Constructor(n int) Allocator {
	return Allocator{
		mem:   make([]int, n),
		sizes: make(map[int]int),
		starts: make(map[int]int),
	}
}

func (this *Allocator) Allocate(size int, mID int) int {
	n := len(this.mem)
	for i := 0; i <= n-size; i++ {
		valid := true
		for j := 0; j < size; j++ {
			if this.mem[i+j] != 0 {
				valid = false
				break
			}
		}
		if valid {
			for j := 0; j < size; j++ {
				this.mem[i+j] = mID
			}
			this.sizes[mID] = size
			this.starts[mID] = i
			return i
		}
	}
	return -1
}

func (this *Allocator) Free(mID int) int {
	size, ok := this.sizes[mID]
	if !ok {
		return 0
	}
	start := this.starts[mID]
	count := 0
	for i := 0; i < size; i++ {
		if this.mem[start+i] == mID {
			this.mem[start+i] = 0
			count++
		}
	}
	delete(this.sizes, mID)
	delete(this.starts, mID)
	return count
}