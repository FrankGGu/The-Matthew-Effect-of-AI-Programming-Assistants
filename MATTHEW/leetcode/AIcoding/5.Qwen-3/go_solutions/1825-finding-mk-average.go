package main

type MKAverage struct {
    m int
    k int
    data []int
    sum int
    count int
    heap1 *Heap
    heap2 *Heap
    heap3 *Heap
}

func Constructor(m int, k int) MKAverage {
    return MKAverage{
        m: m,
        k: k,
        data: make([]int, 0),
        sum: 0,
        count: 0,
        heap1: &Heap{},
        heap2: &Heap{},
        heap3: &Heap{},
    }
}

func (this *MKAverage) AddElement(num int) {
    this.data = append(this.data, num)
    this.count++
    if this.count <= this.m {
        this.sum += num
        return
    }
    if this.count > this.m {
        this.sum -= this.data[this.count-this.m-1]
    }
    this.sum += num
    if this.count > this.m {
        for len(*this.heap1) < this.k {
            if len(*this.heap2) == 0 {
                break
            }
            val := heap.Pop(this.heap2).(int)
            heap.Push(this.heap1, val)
        }
        for len(*this.heap3) < this.k {
            if len(*this.heap2) == 0 {
                break
            }
            val := heap.Pop(this.heap2).(int)
            heap.Push(this.heap3, val)
        }
        if len(*this.heap1) < this.k {
            heap.Push(this.heap2, num)
        } else if num < (*this.heap1)[0] {
            heap.Push(this.heap1, num)
        } else if len(*this.heap3) < this.k {
            heap.Push(this.heap2, num)
        } else if num > (*this.heap3)[0] {
            heap.Push(this.heap3, num)
        } else {
            heap.Push(this.heap2, num)
        }
    }
}

func (this *MKAverage) CalculateMKAverage() int {
    if this.count < this.m {
        return -1
    }
    return this.sum
}

type Heap struct {
    data []int
}

func (h *Heap) Len() int           { return len(h.data) }
func (h *Heap) Less(i, j int) bool { return h.data[i] < h.data[j] }
func (h *Heap) Swap(i, j int)      { h.data[i], h.data[j] = h.data[j], h.data[i] }

func (h *Heap) Push(x interface{}) {
    h.data = append(h.data, x.(int))
}

func (h *Heap) Pop() interface{} {
    old := h.data
    n := len(old)
    x := old[n-1]
    h.data = old[0 : n-1]
    return x
}