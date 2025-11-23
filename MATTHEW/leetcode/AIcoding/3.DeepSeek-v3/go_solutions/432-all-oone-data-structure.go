type Node struct {
    keys map[string]bool
    count int
    prev, next *Node
}

type AllOne struct {
    root *Node
    nodes map[string]*Node
}

func Constructor() AllOne {
    root := &Node{keys: make(map[string]bool), count: 0}
    root.prev, root.next = root, root
    return AllOne{root: root, nodes: make(map[string]*Node)}
}

func (this *AllOne) Inc(key string) {
    if node, ok := this.nodes[key]; ok {
        this.removeKeyFromNode(node, key)
        next := node.next
        if next == this.root || next.count > node.count+1 {
            next = &Node{keys: make(map[string]bool), count: node.count + 1, prev: node, next: node.next}
            node.next.prev = next
            node.next = next
        }
        next.keys[key] = true
        this.nodes[key] = next
    } else {
        node := this.root.next
        if node == this.root || node.count > 1 {
            node = &Node{keys: make(map[string]bool), count: 1, prev: this.root, next: this.root.next}
            this.root.next.prev = node
            this.root.next = node
        }
        node.keys[key] = true
        this.nodes[key] = node
    }
}

func (this *AllOne) Dec(key string) {
    node := this.nodes[key]
    this.removeKeyFromNode(node, key)
    if node.count == 1 {
        delete(this.nodes, key)
    } else {
        prev := node.prev
        if prev == this.root || prev.count < node.count-1 {
            prev = &Node{keys: make(map[string]bool), count: node.count - 1, prev: node.prev, next: node}
            node.prev.next = prev
            node.prev = prev
        }
        prev.keys[key] = true
        this.nodes[key] = prev
    }
}

func (this *AllOne) removeKeyFromNode(node *Node, key string) {
    delete(node.keys, key)
    if len(node.keys) == 0 {
        node.prev.next = node.next
        node.next.prev = node.prev
    }
}

func (this *AllOne) GetMaxKey() string {
    if this.root.prev == this.root {
        return ""
    }
    for key := range this.root.prev.keys {
        return key
    }
    return ""
}

func (this *AllOne) GetMinKey() string {
    if this.root.next == this.root {
        return ""
    }
    for key := range this.root.next.keys {
        return key
    }
    return ""
}