type LockingTree struct {
	parent []int
	locks  []int
	child  [][]int
}

func Constructor(parent []int) LockingTree {
	n := len(parent)
	child := make([][]int, n)
	for i := 1; i < n; i++ {
		child[parent[i]] = append(child[parent[i]], i)
	}
	return LockingTree{
		parent: parent,
		locks:  make([]int, n),
		child:  child,
	}
}

func (this *LockingTree) Lock(num int, user int) bool {
	if this.locks[num] == 0 {
		this.locks[num] = user
		return true
	}
	return false
}

func (this *LockingTree) Unlock(num int, user int) bool {
	if this.locks[num] == user {
		this.locks[num] = 0
		return true
	}
	return false
}

func (this *LockingTree) Upgrade(num int, user int) bool {
	if this.locks[num] != 0 {
		return false
	}

	p := num
	for p != -1 {
		if this.locks[p] != 0 {
			return false
		}
		p = this.parent[p]
	}

	count := 0
	var dfs func(int)
	dfs = func(node int) {
		if this.locks[node] != 0 {
			count++
			this.locks[node] = 0
		}
		for _, child := range this.child[node] {
			dfs(child)
		}
	}
	dfs(num)

	if count > 0 {
		this.locks[num] = user
		return true
	}

	return false
}