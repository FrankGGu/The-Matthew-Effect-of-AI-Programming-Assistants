package main

type Allocator struct {
    memory []int
}

func Constructor(n int) Allocator {
    return Allocator{
        memory: make([]int, n),
    }
}

func (this *Allocator) Allocate(m size_t, start int, end int) int {
    for i := start; i < end; i++ {
        if this.memory[i] != 0 {
            return -1
        }
    }
    for i := start; i < end; i++ {
        this.memory[i] = 1
    }
    return start
}

func (this *Allocator) Free(pid int) int {
    count := 0
    for i := 0; i < len(this.memory); i++ {
        if this.memory[i] == pid {
            this.memory[i] = 0
            count++
        }
    }
    return count
}