type Allocator struct {
    memory []byte
    size   int
    free   []int
}

func Constructor(size int) Allocator {
    return Allocator{
        memory: make([]byte, size),
        size:   size,
        free:   []int{0},
    }
}

func (this *Allocator) Allocate(size int) int {
    for i := 0; i < len(this.free); i++ {
        start := this.free[i]
        end := start
        for end < this.size && this.memory[end] == 0 {
            end++
        }
        if end-start >= size {
            for j := start; j < start+size; j++ {
                this.memory[j] = 1
            }
            if end-start > size {
                this.free[i] = start + size
            } else {
                this.free = append(this.free[:i], this.free[i+1:]...)
            }
            return start
        }
    }
    return -1
}

func (this *Allocator) Free(start int, size int) {
    for i := start; i < start+size; i++ {
        this.memory[i] = 0
    }
    this.free = append(this.free, start)
}