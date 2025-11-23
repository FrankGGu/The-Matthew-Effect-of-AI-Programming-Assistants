type LockingTree struct {
    parent   []int
    lockedBy []int // -1 if unlocked, user_id if locked
    children [][]int
}

func Constructor(parent []int) LockingTree {
    n := len(parent)
    lockedBy := make([]int, n)
    for i := range lockedBy {
        lockedBy[i] = -1 // All nodes initially unlocked
    }

    children := make([][]int, n)
    for i := 1; i < n; i++ { // Node 0 is root, has no parent in parent array (parent[0] is -1).
        p := parent[i]
        children[p] = append(children[p], i)
    }

    return LockingTree{
        parent:   parent,
        lockedBy: lockedBy,
        children: children,
    }
}

func (this *LockingTree) Lock(num int, user int) bool {
    if this.lockedBy[num] == -1 {
        this.lockedBy[num] = user
        return true
    }
    return false
}

func (this *LockingTree) Unlock(num int, user int) bool {
    if this.lockedBy[num] == user {
        this.lockedBy[num] = -1
        return true
    }
    return false
}

func (this *LockingTree) Upgrade(num int, user int) bool {
    // Condition 1: Node num must be unlocked
    if this.lockedBy[num] != -1 {
        return false
    }

    // Condition 3: No ancestor of num must be locked
    curr := this.parent[num] // Start checking from the direct parent of num
    for curr != -1 {
        if this.lockedBy[curr] != -1 {
            return false // An ancestor is locked
        }
        curr = this.parent[curr]
    }

    // Condition 2: At least one descendant of num must be locked
    // Also collect all locked descendants to unlock them later
    foundLockedDescendant := false
    var descendantsToUnlock []int

    // Use a queue for BFS to find all descendants
    queue := []int{num} // Start BFS from 'num' to explore its subtree
    head := 0
    for head < len(queue) {
        node := queue[head]
        head++

        // Check if this 'node' (which is a descendant of 'num' or 'num' itself) is locked.
        // We only care about *actual descendants* for the 'foundLockedDescendant' condition.
        // But all nodes in the subtree (except num itself) are potential candidates for unlocking.
        if node != num && this.lockedBy[node] != -1 {
            foundLockedDescendant = true
            descendantsToUnlock = append(descendantsToUnlock, node)
        }

        // Add children to the queue for further exploration
        for _, child := range this.children[node] {
            queue = append(queue, child)
        }
    }

    // If no locked descendants were found, condition 2 is not met
    if !foundLockedDescendant {
        return false
    }

    // All three conditions are met:
    // 1. Lock node num for the given user
    this.lockedBy[num] = user
    // 2. Unlock all previously locked descendants
    for _, d := range descendantsToUnlock {
        this.lockedBy[d] = -1
    }

    return true
}