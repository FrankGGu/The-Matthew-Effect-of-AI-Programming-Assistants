type BlackBox struct {
    n, m int
    pos []int
    visited map[int]bool
}

func Constructor(n int, m int) BlackBox {
    return BlackBox{
        n: n,
        m: m,
        pos: make([]int, 8),
        visited: make(map[int]bool),
    }
}

func (this *BlackBox) Open(index int, direction int) int {
    key := index*10 + direction
    if this.visited[key] {
        return -1
    }
    this.visited[key] = true
    next := this.findNext(index, direction)
    return next
}

func (this *BlackBox) findNext(index int, direction int) int {
    if direction == 1 || direction == 3 {
        total := this.n + this.m
        if direction == 1 {
            next := total - index
            if next == this.n || next == total {
                return index
            }
            if next < this.n {
                return this.findNext(next, 2)
            } else {
                return this.findNext(next, 4)
            }
        } else {
            next := 2*this.n + 2*this.m - index
            if next == 0 || next == this.n + this.m {
                return index
            }
            if next < this.n {
                return this.findNext(next, 2)
            } else {
                return this.findNext(next, 4)
            }
        }
    } else {
        if direction == 2 {
            next := 2*this.n - index
            if next == 0 || next == this.n {
                return index
            }
            if next < this.n {
                return this.findNext(next, 1)
            } else {
                return this.findNext(next, 3)
            }
        } else {
            next := 2*this.m + 2*this.n - index
            if next == this.n || next == this.n + this.m {
                return index
            }
            if next < this.n {
                return this.findNext(next, 1)
            } else {
                return this.findNext(next, 3)
            }
        }
    }
}

func (this *BlackBox) Close(index int) {
    for d := 1; d <= 4; d++ {
        key := index*10 + d
        delete(this.visited, key)
    }
}