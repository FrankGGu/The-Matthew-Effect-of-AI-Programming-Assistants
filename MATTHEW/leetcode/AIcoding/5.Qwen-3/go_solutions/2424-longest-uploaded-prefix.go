package main

type LUPrefix struct {
    data []bool
    ptr  int
}

func Constructor(n int) LUPrefix {
    return LUPrefix{
        data: make([]bool, n),
        ptr:  0,
    }
}

func (this *LUPrefix) Upload(video int) {
    this.data[video] = true
    for this.ptr < len(this.data) && this.data[this.ptr] {
        this.ptr++
    }
}

func (this *LUPrefix) Longest() int {
    return this.ptr
}