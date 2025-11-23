type SegmentTreeNode struct {
    left, right *SegmentTreeNode
    l, r        int
    maxLen      int
    prefixLen   int
    suffixLen   int
    leftChar    byte
    rightChar   byte
}

func (node *SegmentTreeNode) update(c byte) {
    node.leftChar = c
    node.rightChar = c
    node.maxLen = 1
    node.prefixLen = 1
    node.suffixLen = 1
}

func (node *SegmentTreeNode) merge(left, right *SegmentTreeNode) {
    node.leftChar = left.leftChar
    node.rightChar = right.rightChar

    node.prefixLen = left.prefixLen
    if left.prefixLen == left.r-left.l+1 && left.rightChar == right.leftChar {
        node.prefixLen += right.prefixLen
    }

    node.suffixLen = right.suffixLen
    if right.suffixLen == right.r-right.l+1 && left.rightChar == right.leftChar {
        node.suffixLen += left.suffixLen
    }

    node.maxLen = max(left.maxLen, right.maxLen)
    if left.rightChar == right.leftChar {
        node.maxLen = max(node.maxLen, left.suffixLen+right.prefixLen)
    }
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func build(l, r int, s string) *SegmentTreeNode {
    node := &SegmentTreeNode{l: l, r: r}
    if l == r {
        node.update(s[l])
        return node
    }
    mid := (l + r) / 2
    node.left = build(l, mid, s)
    node.right = build(mid+1, r, s)
    node.merge(node.left, node.right)
    return node
}

func update(node *SegmentTreeNode, pos int, c byte) {
    if node.l == node.r {
        node.update(c)
        return
    }
    if pos <= node.left.r {
        update(node.left, pos, c)
    } else {
        update(node.right, pos, c)
    }
    node.merge(node.left, node.right)
}

func longestRepeating(s string, queryCharacters string, queryIndices []int) []int {
    n := len(s)
    root := build(0, n-1, s)
    res := make([]int, len(queryIndices))
    for i := 0; i < len(queryIndices); i++ {
        pos := queryIndices[i]
        c := queryCharacters[i]
        if s[pos] != c {
            update(root, pos, c)
            s = s[:pos] + string(c) + s[pos+1:]
        }
        res[i] = root.maxLen
    }
    return res
}