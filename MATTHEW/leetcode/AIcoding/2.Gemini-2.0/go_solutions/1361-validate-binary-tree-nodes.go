func validateBinaryTreeNodes(n int, leftChild []int, rightChild []int) bool {
	inDegree := make([]int, n)
	for i := 0; i < n; i++ {
		if leftChild[i] != -1 {
			inDegree[leftChild[i]]++
		}
		if rightChild[i] != -1 {
			inDegree[rightChild[i]]++
		}
	}

	root := -1
	countRoot := 0
	for i := 0; i < n; i++ {
		if inDegree[i] == 0 {
			root = i
			countRoot++
		}
	}

	if countRoot != 1 {
		return false
	}

	visited := make([]bool, n)
	queue := []int{root}
	visited[root] = true
	countVisited := 0

	for len(queue) > 0 {
		node := queue[0]
		queue = queue[1:]
		countVisited++

		left := leftChild[node]
		if left != -1 {
			if visited[left] {
				return false
			}
			visited[left] = true
			queue = append(queue, left)
		}

		right := rightChild[node]
		if right != -1 {
			if visited[right] {
				return false
			}
			visited[right] = true
			queue = append(queue, right)
		}
	}

	return countVisited == n
}