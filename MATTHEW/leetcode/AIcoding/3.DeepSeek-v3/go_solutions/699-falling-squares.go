type Interval struct {
    start, end, height int
}

type Node struct {
    left, right *Node
    interval    Interval
    max         int
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func buildTree(start, end int) *Node {
    node := &Node{
        interval: Interval{start, end, 0},
        max:      0,
    }
    if start < end {
        mid := start + (end-start)/2
        node.left = buildTree(start, mid)
        node.right = buildTree(mid+1, end)
    }
    return node
}

func update(node *Node, start, end, height int) int {
    if node.interval.start > end || node.interval.end < start {
        return node.interval.height
    }
    if start <= node.interval.start && node.interval.end <= end {
        node.interval.height = height
        node.max = height
        return height
    }
    leftHeight := update(node.left, start, end, height)
    rightHeight := update(node.right, start, end, height)
    node.interval.height = max(leftHeight, rightHeight)
    node.max = max(node.left.max, node.right.max)
    return node.interval.height
}

func query(node *Node, start, end int) int {
    if node.interval.start > end || node.interval.end < start {
        return 0
    }
    if start <= node.interval.start && node.interval.end <= end {
        return node.max
    }
    leftMax := query(node.left, start, end)
    rightMax := query(node.right, start, end)
    return max(leftMax, rightMax)
}

func fallingSquares(positions [][]int) []int {
    var res []int
    var intervals []Interval
    maxPos := 0
    for _, pos := range positions {
        left, side := pos[0], pos[1]
        right := left + side - 1
        maxPos = max(maxPos, right)
    }
    root := buildTree(0, maxPos)
    currentMax := 0
    for _, pos := range positions {
        left, side := pos[0], pos[1]
        right := left + side - 1
        h := query(root, left, right)
        newHeight := h + side
        update(root, left, right, newHeight)
        currentMax = max(currentMax, newHeight)
        res = append(res, currentMax)
    }
    return res
}