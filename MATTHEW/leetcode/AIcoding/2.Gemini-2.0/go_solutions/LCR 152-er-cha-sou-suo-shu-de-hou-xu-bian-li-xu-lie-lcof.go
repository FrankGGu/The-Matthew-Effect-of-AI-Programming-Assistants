func verifyPostorder(postorder []int) bool {
	if len(postorder) <= 1 {
		return true
	}

	root := postorder[len(postorder)-1]
	i := 0
	for i < len(postorder)-1 && postorder[i] < root {
		i++
	}

	for j := i; j < len(postorder)-1; j++ {
		if postorder[j] < root {
			return false
		}
	}

	return verifyPostorder(postorder[:i]) && verifyPostorder(postorder[i:len(postorder)-1])
}