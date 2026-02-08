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

func (this *FrontMiddleBackQueue) balance() {
    for len(this.front) > len(this.back)+1 {
        val := this.front[len(this.front)-1]
        this.front = this.front[:len(this.front)-1]
        this.back = append([]int{val}, this.back...)
    }
    for len(this.back) > len(this.front) {
        val := this.back[0]
        this.back = this.back[1:]
        this.front = append(this.front, val)
    }
}

func (this *FrontMiddleBackQueue) PushFront(val int) {
    this.front = append([]int{val}, this.front...)
    this.balance()
}

func (this *FrontMiddleBackQueue) PushMiddle(val int) {
    if len(this.front) > len(this.back) {
        this.back = append([]int{this.front[len(this.front)-1]}, this.back...)
        this.front[len(this.front)-1] = val
    } else {
        this.front = append(this.front, val)
    }
    this.balance()
}

func (this *FrontMiddleBackQueue) PushBack(val int) {
    this.back = append(this.back, val)
    this.balance()
}

func (this *FrontMiddleBackQueue) PopFront() int {
    if len(this.front) == 0 && len(this.back) == 0 {
        return -1
    }
    var val int
    if len(this.front) > 0 {
        val = this.front[0]
        this.front = this.front[1:]
    } else {
        val = this.back[0]
        this.back = this.back[1:]
    }
    this.balance()
    return val
}

func (this *FrontMiddleBackQueue) PopMiddle() int {
    if len(this.front) == 0 && len(this.back) == 0 {
        return -1
    }
    var val int
    if len(this.front) == len(this.back) {
        val = this.front[len(this.front)-1]
        this.front = this.front[:len(this.front)-1]
    } else {
        val = this.front[len(this.front)-1]
        this.front = this.front[:len(this.front)-1]
    }
    this.balance()
    return val
}

func (this *FrontMiddleBackQueue) PopBack() int {
    if len(this.front) == 0 && len(this.back) == 0 {
        return -1
    }
    var val int
    if len(this.back) > 0 {
        val = this.back[len(this.back)-1]
        this.back = this.back[:len(this.back)-1]
    } else {
        val = this.front[len(this.front)-1]
        this.front = this.front[:len(this.front)-1]
    }
    this.balance()
    return val
}