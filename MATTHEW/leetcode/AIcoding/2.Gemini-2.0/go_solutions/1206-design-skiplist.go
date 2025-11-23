import "math/rand"

type SkiplistNode struct {
	val  int
	next []*SkiplistNode
}

type Skiplist struct {
	level int
	head  *SkiplistNode
}

func Constructor() Skiplist {
	return Skiplist{
		level: 0,
		head: &SkiplistNode{
			val:  -1,
			next: make([]*SkiplistNode, 16),
		},
	}
}

func (this *Skiplist) Search(target int) bool {
	curr := this.head
	for i := this.level; i >= 0; i-- {
		for curr.next[i] != nil && curr.next[i].val < target {
			curr = curr.next[i]
		}
	}
	curr = curr.next[0]
	return curr != nil && curr.val == target
}

func (this *Skiplist) Add(num int) {
	update := make([]*SkiplistNode, 16)
	curr := this.head
	for i := this.level; i >= 0; i-- {
		for curr.next[i] != nil && curr.next[i].val < num {
			curr = curr.next[i]
		}
		update[i] = curr
	}

	level := this.randomLevel()
	if level > this.level {
		for i := this.level + 1; i <= level; i++ {
			update[i] = this.head
		}
		this.level = level
	}

	newNode := &SkiplistNode{
		val:  num,
		next: make([]*SkiplistNode, level+1),
	}

	for i := 0; i <= level; i++ {
		newNode.next[i] = update[i].next[i]
		update[i].next[i] = newNode
	}
}

func (this *Skiplist) Erase(num int) bool {
	update := make([]*SkiplistNode, 16)
	curr := this.head
	for i := this.level; i >= 0; i-- {
		for curr.next[i] != nil && curr.next[i].val < num {
			curr = curr.next[i]
		}
		update[i] = curr
	}

	curr = curr.next[0]
	if curr == nil || curr.val != num {
		return false
	}

	for i := 0; i <= this.level; i++ {
		if update[i].next[i] != curr {
			break
		}
		update[i].next[i] = curr.next[i]
	}

	for this.level > 0 && this.head.next[this.level] == nil {
		this.level--
	}

	return true
}

func (this *Skiplist) randomLevel() int {
	level := 0
	for rand.Float64() < 0.5 && level < 15 {
		level++
	}
	return level
}