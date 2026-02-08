package main

import "math/rand"

type Node struct {
	value  int
	next   []*Node
}

type Skiplist struct {
	head *Node
	level int
}

func Constructor() Skiplist {
	return Skiplist{
		head: &Node{next: make([]*Node, 32)},
		level: 0,
	}
}

func (this *Skiplist) Search(target int) bool {
	node := this.head
	for i := this.level; i >= 0; i-- {
		for node.next[i] != nil && node.next[i].value < target {
			node = node.next[i]
		}
	}
	node = node.next[0]
	return node != nil && node.value == target
}

func (this *Skiplist) Add(num int) {
	update := make([]*Node, 32)
	node := this.head

	for i := this.level; i >= 0; i-- {
		for node.next[i] != nil && node.next[i].value < num {
			node = node.next[i]
		}
		update[i] = node
	}

	node = node.next[0]
	if node == nil || node.value != num {
		level := randomLevel()
		if level > this.level {
			for i := this.level + 1; i <= level; i++ {
				update[i] = this.head
			}
			this.level = level
		}
		newNode := &Node{value: num, next: make([]*Node, level+1)}
		for i := 0; i <= level; i++ {
			newNode.next[i] = update[i].next[i]
			update[i].next[i] = newNode
		}
	}
}

func (this *Skiplist) Erase(num int) bool {
	update := make([]*Node, 32)
	node := this.head

	for i := this.level; i >= 0; i-- {
		for node.next[i] != nil && node.next[i].value < num {
			node = node.next[i]
		}
		update[i] = node
	}

	node = node.next[0]
	if node == nil || node.value != num {
		return false
	}

	for i := 0; i <= this.level; i++ {
		if update[i].next[i] != node {
			break
		}
		update[i].next[i] = node.next[i]
	}

	for this.level > 0 && this.head.next[this.level] == nil {
		this.level--
	}

	return true
}

func randomLevel() int {
	level := 0
	for rand.Intn(2) == 0 {
		level++
	}
	return level
}

/**
 * Your Skiplist object will be instantiated and called as such:
 * obj := Constructor();
 * param_1 := obj.Search(target);
 * obj.Add(num);
 * param_3 := obj.Erase(num);
 */