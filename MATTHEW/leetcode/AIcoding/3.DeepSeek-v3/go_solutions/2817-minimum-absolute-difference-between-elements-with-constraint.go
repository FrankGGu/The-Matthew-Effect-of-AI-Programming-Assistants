func minAbsoluteDifference(nums []int, x int) int {
    n := len(nums)
    if n < 2 {
        return 0
    }
    res := math.MaxInt32
    tree := &TreeSet{}
    for i := x; i < n; i++ {
        tree.Insert(nums[i-x])
        val := nums[i]
        floor := tree.Floor(val)
        if floor != nil {
            res = min(res, abs(val - *floor))
        }
        ceiling := tree.Ceiling(val)
        if ceiling != nil {
            res = min(res, abs(val - *ceiling))
        }
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}

type TreeSet struct {
    root *Node
}

type Node struct {
    val   int
    left  *Node
    right *Node
}

func (t *TreeSet) Insert(val int) {
    t.root = t.insert(t.root, val)
}

func (t *TreeSet) insert(node *Node, val int) *Node {
    if node == nil {
        return &Node{val: val}
    }
    if val < node.val {
        node.left = t.insert(node.left, val)
    } else if val > node.val {
        node.right = t.insert(node.right, val)
    }
    return node
}

func (t *TreeSet) Floor(val int) *int {
    var floor *int
    node := t.root
    for node != nil {
        if node.val == val {
            return &node.val
        } else if node.val < val {
            floor = &node.val
            node = node.right
        } else {
            node = node.left
        }
    }
    return floor
}

func (t *TreeSet) Ceiling(val int) *int {
    var ceiling *int
    node := t.root
    for node != nil {
        if node.val == val {
            return &node.val
        } else if node.val > val {
            ceiling = &node.val
            node = node.left
        } else {
            node = node.right
        }
    }
    return ceiling
}