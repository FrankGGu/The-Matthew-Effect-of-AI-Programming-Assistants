type LockingTree struct {
    parent []int
    locked []int
    children [][]int
}

func Constructor(parent []int) LockingTree {
    n := len(parent)
    locked := make([]int, n)
    for i := range locked {
        locked[i] = -1
    }
    children := make([][]int, n)
    for i := 1; i < n; i++ {
        p := parent[i]
        children[p] = append(children[p], i)
    }
    return LockingTree{parent, locked, children}
}

func (this *LockingTree) Lock(num int, user int) bool {
    if this.locked[num] == -1 {
        this.locked[num] = user
        return true
    }
    return false
}

func (this *LockingTree) Unlock(num int, user int) bool {
    if this.locked[num] == user {
        this.locked[num] = -1
        return true
    }
    return false
}

func (this *LockingTree) Upgrade(num int, user int) bool {
    if this.locked[num] != -1 {
        return false
    }
    if !this.hasLockedAncestor(num) && this.hasLockedDescendant(num) {
        this.unlockDescendants(num)
        this.locked[num] = user
        return true
    }
    return false
}

func (this *LockingTree) hasLockedAncestor(num int) bool {
    for p := this.parent[num]; p != -1; p = this.parent[p] {
        if this.locked[p] != -1 {
            return true
        }
    }
    return false
}

func (this *LockingTree) hasLockedDescendant(num int) bool {
    queue := []int{num}
    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        for _, child := range this.children[node] {
            if this.locked[child] != -1 {
                return true
            }
            queue = append(queue, child)
        }
    }
    return false
}

func (this *LockingTree) unlockDescendants(num int) {
    queue := []int{num}
    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        for _, child := range this.children[node] {
            this.locked[child] = -1
            queue = append(queue, child)
        }
    }
}