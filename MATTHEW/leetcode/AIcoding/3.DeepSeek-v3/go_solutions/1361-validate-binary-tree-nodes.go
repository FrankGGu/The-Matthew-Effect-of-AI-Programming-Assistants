func validateBinaryTreeNodes(n int, leftChild []int, rightChild []int) bool {
    parent := make([]int, n)
    for i := range parent {
        parent[i] = -1
    }

    for i := 0; i < n; i++ {
        l := leftChild[i]
        if l != -1 {
            if parent[l] != -1 {
                return false
            }
            parent[l] = i
        }
        r := rightChild[i]
        if r != -1 {
            if parent[r] != -1 {
                return false
            }
            parent[r] = i
        }
    }

    root := -1
    for i := 0; i < n; i++ {
        if parent[i] == -1 {
            if root != -1 {
                return false
            }
            root = i
        }
    }
    if root == -1 {
        return false
    }

    visited := make([]bool, n)
    queue := []int{root}
    visited[root] = true
    count := 1

    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        l := leftChild[node]
        if l != -1 {
            if visited[l] {
                return false
            }
            visited[l] = true
            queue = append(queue, l)
            count++
        }
        r := rightChild[node]
        if r != -1 {
            if visited[r] {
                return false
            }
            visited[r] = true
            queue = append(queue, r)
            count++
        }
    }

    return count == n
}