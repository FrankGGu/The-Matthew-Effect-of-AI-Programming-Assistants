import (
    "math/rand"
)

const maxLevel = 32
const pFactor = 0.25

type SkiplistNode struct {
    val int
    next []*SkiplistNode
}

type Skiplist struct {
    head *SkiplistNode
    level int
}

func Constructor() Skiplist {
    return Skiplist{
        head: &SkiplistNode{val: -1, next: make([]*SkiplistNode, maxLevel)},
        level: 0,
    }
}

func (this *Skiplist) randomLevel() int {
    lvl := 1
    for lvl < maxLevel && rand.Float64() < pFactor {
        lvl++
    }
    return lvl
}

func (this *Skiplist) Search(target int) bool {
    curr := this.head
    for i := this.level - 1; i >= 0; i-- {
        for curr.next[i] != nil && curr.next[i].val < target {
            curr = curr.next[i]
        }
    }
    curr = curr.next[0]
    return curr != nil && curr.val == target
}

func (this *Skiplist) Add(num int) {
    update := make([]*SkiplistNode, maxLevel)
    for i := range update {
        update[i] = this.head
    }
    curr := this.head
    for i := this.level - 1; i >= 0; i-- {
        for curr.next[i] != nil && curr.next[i].val < num {
            curr = curr.next[i]
        }
        update[i] = curr
    }
    lvl := this.randomLevel()
    if lvl > this.level {
        for i := this.level; i < lvl; i++ {
            update[i] = this.head
        }
        this.level = lvl
    }
    newNode := &SkiplistNode{val: num, next: make([]*SkiplistNode, lvl)}
    for i := 0; i < lvl; i++ {
        newNode.next[i] = update[i].next[i]
        update[i].next[i] = newNode
    }
}

func (this *Skiplist) Erase(num int) bool {
    update := make([]*SkiplistNode, maxLevel)
    curr := this.head
    for i := this.level - 1; i >= 0; i-- {
        for curr.next[i] != nil && curr.next[i].val < num {
            curr = curr.next[i]
        }
        update[i] = curr
    }
    curr = curr.next[0]
    if curr == nil || curr.val != num {
        return false
    }
    for i := 0; i < this.level; i++ {
        if update[i].next[i] != curr {
            break
        }
        update[i].next[i] = curr.next[i]
    }
    for this.level > 1 && this.head.next[this.level-1] == nil {
        this.level--
    }
    return true
}