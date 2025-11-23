package main

func verifyPostorder(postorder []int) bool {
	return helper(postorder, 0, len(postorder)-1)
}

func helper(postorder []int, i, j int) bool {
	if i >= j {
		return true
	}

	rootVal := postorder[j]

	m := i
	for postorder[m] < rootVal {
		m++
	}

	p := m
	for p < j {
		if postorder[p] <= rootVal {
			return false
		}
		p++
	}

	return helper(postorder, i, m-1) && helper(postorder, m, j-1)
}