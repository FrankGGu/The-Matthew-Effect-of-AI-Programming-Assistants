package main

type Node struct {
    keys     map[string]struct{}
    count    int
    prev     *Node
    next     *Node
}

type AllOne struct {
    head *Node
    tail *Node
    countMap map[string]int
    nodeMap  map[int]*Node
}

func Constructor() AllOne {
    head := &Node{keys: make(map[string]struct{}), count: 0}
    tail := &Node{keys: make(map[string]struct{}), count: 0}
    head.next = tail
    tail.prev = head
    return AllOne{
        head:     head,
        tail:     tail,
        countMap: make(map[string]int),
        nodeMap:  make(map[int]*Node),
    }
}

func (this *AllOne) Inc(key string) {
    if _, exists := this.countMap[key]; !exists {
        this.countMap[key] = 0
    }
    currentCount := this.countMap[key]
    this.countMap[key]++

    if currentCount > 0 {
        this.removeKey(key, currentCount)
    }

    newCount := this.countMap[key]
    this.insertKey(key, newCount)
}

func (this *AllOne) Dec(key string) {
    if _, exists := this.countMap[key]; !exists || this.countMap[key] == 0 {
        return
    }
    currentCount := this.countMap[key]
    this.removeKey(key, currentCount)

    this.countMap[key]--
    newCount := this.countMap[key]
    if newCount > 0 {
        this.insertKey(key, newCount)
    } else {
        delete(this.countMap, key)
    }
}

func (this *AllOne) GetMaxKey() string {
    if this.tail.prev == this.head {
        return ""
    }
    for key := range this.tail.prev.keys {
        return key
    }
    return ""
}

func (this *AllOne) GetMinKey() string {
    if this.head.next == this.tail {
        return ""
    }
    for key := range this.head.next.keys {
        return key
    }
    return ""
}

func (this *AllOne) removeKey(key string, count int) {
    node := this.nodeMap[count]
    delete(node.keys, key)
    if len(node.keys) == 0 {
        this.removeNode(node)
        delete(this.nodeMap, count)
    }
}

func (this *AllOne) insertKey(key string, count int) {
    if _, exists := this.nodeMap[count]; !exists {
        newNode := &Node{keys: make(map[string]struct{}), count: count}
        this.nodeMap[count] = newNode
        this.insertNode(newNode)
    }
    this.nodeMap[count].keys[key] = struct{}{}
}

func (this *AllOne) insertNode(node *Node) {
    prevNode := this.head
    for prevNode.next != this.tail && prevNode.next.count < node.count {
        prevNode = prevNode.next
    }
    node.prev = prevNode
    node.next = prevNode.next
    prevNode.next.prev = node
    prevNode.next = node
}

func (this *AllOne) removeNode(node *Node) {
    node.prev.next = node.next
    node.next.prev = node.prev
}