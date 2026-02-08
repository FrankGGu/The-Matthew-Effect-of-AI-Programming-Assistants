package main

type Skiplist struct {
    head *Node
}

type Node struct {
    val  int
    next []*Node
}

func Constructor() Skiplist {
    return Skiplist{
        head: &Node{
            next: make([]*Node, 1),
        },
    }
}

func (this *Skiplist) search(target int) []*Node {
    current := this.head
    res := make([]*Node, len(current.next))
    for i := len(current.next) - 1; i >= 0; i-- {
        for current.next[i] != nil && current.next[i].val < target {
            current = current.next[i]
        }
        res[i] = current
    }
    return res
}

func (this *Skiplist) searchInsert(target int) []*Node {
    current := this.head
    res := make([]*Node, len(current.next))
    for i := len(current.next) - 1; i >= 0; i-- {
        for current.next[i] != nil && current.next[i].val < target {
            current = current.next[i]
        }
        res[i] = current
    }
    return res
}

func (this *Skiplist) add(num int) {
    node := &Node{
        val:  num,
        next: make([]*Node, len(this.head.next)),
    }
    for i := 0; i < len(node.next); i++ {
        node.next[i] = nil
    }
    current := this.head
    for i := len(current.next) - 1; i >= 0; i-- {
        for current.next[i] != nil && current.next[i].val < num {
            current = current.next[i]
        }
        if i < len(node.next) {
            node.next[i] = current.next[i]
            current.next[i] = node
        }
    }
}

func (this *Skiplist) erase(num int) bool {
    current := this.head
    found := false
    for i := len(current.next) - 1; i >= 0; i-- {
        for current.next[i] != nil && current.next[i].val < num {
            current = current.next[i]
        }
        if current.next[i] != nil && current.next[i].val == num {
            current.next[i] = current.next[i].next[i]
            found = true
        }
    }
    return found
}

func (this *Skiplist) get(index int) int {
    current := this.head
    count := 0
    for current.next[0] != nil {
        if count == index {
            return current.next[0].val
        }
        current = current.next[0]
        count++
    }
    return -1
}

func (this *Skiplist) search(target int) bool {
    current := this.head
    for i := len(current.next) - 1; i >= 0; i-- {
        for current.next[i] != nil && current.next[i].val < target {
            current = current.next[i]
        }
    }
    return current.next[0] != nil && current.next[0].val == target
}