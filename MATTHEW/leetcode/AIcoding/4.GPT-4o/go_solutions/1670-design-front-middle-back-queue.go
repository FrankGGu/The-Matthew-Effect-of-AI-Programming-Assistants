type FrontMiddleBackQueue struct {
    front []int
    back  []int
}

func Constructor() FrontMiddleBackQueue {
    return FrontMiddleBackQueue{
        front: []int{},
        back:  []int{},
    }
}

func (q *FrontMiddleBackQueue) PushFront(val int) {
    q.front = append(q.front, 0)
    copy(q.front[1:], q.front)
    q.front[0] = val
}

func (q *FrontMiddleBackQueue) PushMiddle(val int) {
    if len(q.front) < len(q.back) {
        q.front = append(q.front, 0)
        copy(q.front[1:], q.front)
        q.front[0] = q.back[0]
        q.back[0] = val
    } else {
        q.back = append(q.back, 0)
        copy(q.back[1:], q.back)
        q.back[0] = val
    }
}

func (q *FrontMiddleBackQueue) PushBack(val int) {
    q.back = append(q.back, val)
}

func (q *FrontMiddleBackQueue) PopFront() int {
    if len(q.front) == 0 && len(q.back) == 0 {
        return -1
    }
    if len(q.front) > 0 {
        res := q.front[0]
        q.front = q.front[1:]
        return res
    }
    res := q.back[0]
    q.back = q.back[1:]
    return res
}

func (q *FrontMiddleBackQueue) PopMiddle() int {
    if len(q.front) == 0 && len(q.back) == 0 {
        return -1
    }
    if len(q.front) == len(q.back) {
        res := q.front[len(q.front)-1]
        q.front = q.front[:len(q.front)-1]
        return res
    }
    res := q.back[0]
    q.back = q.back[1:]
    return res
}

func (q *FrontMiddleBackQueue) PopBack() int {
    if len(q.front) == 0 && len(q.back) == 0 {
        return -1
    }
    if len(q.back) > 0 {
        res := q.back[len(q.back)-1]
        q.back = q.back[:len(q.back)-1]
        return res
    }
    res := q.front[len(q.front)-1]
    q.front = q.front[:len(q.front)-1]
    return res
}