func findTheWinner(n int, k int) int {
	friends := make([]int, n)
	for i := 0; i < n; i++ {
		friends[i] = i + 1
	}

	currentIdx := 0
	for len(friends) > 1 {
		removeIdx := (currentIdx + k - 1) % len(friends)

		friends = append(friends[:removeIdx], friends[removeIdx+1:]...)

		currentIdx = removeIdx % len(friends)
	}

	return friends[0]
}