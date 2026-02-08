package main

type FrontMiddleBackQueue struct {
    front []int
    back  []int
}

func Constructor() FrontMiddleBackQueue {
    return FrontMiddleBackQueue{
        front: make([]int, 0),
        back:  make([]int, 0),
    }
}

func (this *FrontMiddleBackQueue) PushFront(val int) {
    this.front = append(this.front, val)
}

func (this *FrontMiddleBackQueue) PushMiddle(val int) {
    if len(this.front) > len(this.back) {
        this.back = append(this.back, this.front[len(this.front)-1])
        this.front = this.front[:len(this.front)-1]
    }
    this.front = append(this.front, val)
}

func (this *FrontMiddleBackQueue) PushBack(val int) {
    this.back = append(this.back, val)
}

func (this *FrontMiddleBackQueue) PopFront() int {
    if len(this.front) == 0 {
        if len(this.back) == 0 {
            return -1
        }
        return this.back[0]
    }
    val := this.front[len(this.front)-1]
    this.front = this.front[:len(this.front)-1]
    return val
}

func (this *FrontMiddleBackQueue) PopMiddle() int {
    if len(this.front) == 0 {
        if len(this.back) == 0 {
            return -1
        }
        mid := len(this.back) / 2
        val := this.back[mid]
        this.back = append(this.back[:mid], this.back[mid+1:]...)
        return val
    }
    if len(this.front) == len(this.back) {
        val := this.front[len(this.front)-1]
        this.front = this.front[:len(this.front)-1]
        return val
    }
    val := this.front[len(this.front)-1]
    this.front = this.front[:len(this.front)-1]
    this.back = append(this.back, val)
    return val
}

func (this *FrontMiddleBackQueue) PopBack() int {
    if len(this.back) == 0 {
        if len(this.front) == 0 {
            return -1
        }
        return this.front[len(this.front)-1]
    }
    val := this.back[len(this.back)-1]
    this.back = this.back[:len(this.back)-1]
    return val
}