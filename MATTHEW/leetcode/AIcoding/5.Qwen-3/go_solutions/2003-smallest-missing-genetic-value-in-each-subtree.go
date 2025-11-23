package main


func smallestMissingValueSubtree(root *TreeNode) []int {
    n := 0
    var dfs func(*TreeNode)
    dfs = func(node *TreeNode) {
        if node == nil {
            return
        }
        n++
        dfs(node.Left)
        dfs(node.Right)
    }
    dfs(root)

    res := make([]int, n)
    parent := make([]int, n)
    visited := make([]bool, n)
    maxGene := make([]int, n)
    geneToIndex := make(map[int]int)

    var buildParents func(*TreeNode, int)
    buildParents = func(node *TreeNode, idx int) {
        if node == nil {
            return
        }
        parent[idx] = -1
        if node.Left != nil {
            parent[node.Left.Val] = idx
        }
        if node.Right != nil {
            parent[node.Right.Val] = idx
        }
        buildParents(node.Left, node.Left.Val)
        buildParents(node.Right, node.Right.Val)
    }

    buildParents(root, root.Val)

    var findGene func(*TreeNode, int)
    findGene = func(node *TreeNode, g int) {
        if node == nil {
            return
        }
        if node.Val == g {
            geneToIndex[g] = node.Val
            return
        }
        findGene(node.Left, g)
        findGene(node.Right, g)
    }

    for i := 0; i < n; i++ {
        findGene(root, i+1)
    }

    for i := 0; i < n; i++ {
        if geneToIndex[i+1] == 0 {
            res[i] = i + 1
        } else {
            res[i] = 1
        }
    }

    for i := 0; i < n; i++ {
        if geneToIndex[i+1] == 0 {
            continue
        }
        current := geneToIndex[i+1]
        visited[current] = true
        maxGene[current] = i + 1
        for parent[current] != -1 {
            current = parent[current]
            visited[current] = true
            maxGene[current] = max(maxGene[current], i+1)
        }
    }

    for i := 0; i < n; i++ {
        if geneToIndex[i+1] == 0 {
            continue
        }
        current := geneToIndex[i+1]
        for visited[current] {
            current = parent[current]
        }
        res[i] = current + 1
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}