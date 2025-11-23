package main

type TreeAncestor struct {
    up [][]int
}

func (t *TreeAncestor) getKthAncestor(node int, k int) int {
    for k > 0 {
        if node == -1 {
            return -1
        }
        if k&1 == 1 {
            node = t.up[k][node]
        }
        k >>= 1
        if k > 0 {
            k--
        }
    }
    return node
}

func Constructor(n int, parent []int) TreeAncestor {
    maxLevel := 0
    for n > 1 {
        n >>= 1
        maxLevel++
    }
    up := make([][]int, maxLevel)
    up[0] = parent
    for i := 1; i < maxLevel; i++ {
        up[i] = make([]int, len(parent))
        for j := 0; j < len(parent); j++ {
            if up[i-1][j] != -1 {
                up[i][j] = up[i-1][up[i-1][j]]
            } else {
                up[i][j] = -1
            }
        }
    }
    return TreeAncestor{up}
}