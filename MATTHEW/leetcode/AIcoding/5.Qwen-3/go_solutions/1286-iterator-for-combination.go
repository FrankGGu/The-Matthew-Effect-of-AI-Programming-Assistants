package main

type CombinationIterator struct {
    chars []byte
    curr  []int
    next  bool
}

func Constructor(characters string, n int) CombinationIterator {
    chars := []byte(characters)
    curr := make([]int, n)
    for i := range curr {
        curr[i] = i
    }
    return CombinationIterator{chars, curr, true}
}

func (this *CombinationIterator) Next() string {
    res := make([]byte, len(this.curr))
    for i, v := range this.curr {
        res[i] = this.chars[v]
    }
    this.next = false
    for i := len(this.curr) - 1; i >= 0; i-- {
        if this.curr[i] < len(this.chars)-len(this.curr)+i {
            this.curr[i]++
            for j := i + 1; j < len(this.curr); j++ {
                this.curr[j] = this.curr[j-1] + 1
            }
            this.next = true
            break
        }
    }
    return string(res)
}

func (this *CombinationIterator) HasNext() bool {
    return this.next
}