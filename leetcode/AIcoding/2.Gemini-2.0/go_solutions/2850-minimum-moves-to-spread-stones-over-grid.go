import "math"

func minimumMoves(grid [][]int) int {
	n := len(grid)
	zeros := []struct{ x, y int }{}
	excess := []struct{ x, y int }{}

	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if grid[i][j] == 0 {
				zeros = append(zeros, struct{ x, y int }{i, j})
			} else if grid[i][j] > 1 {
				for k := 0; k < grid[i][j]-1; k++ {
					excess = append(excess, struct{ x, y int }{i, j})
				}
			}
		}
	}

	minMoves := math.MaxInt32
	permute(excess, 0, func(perm []struct{ x, y int }) {
		moves := 0
		for i := 0; i < len(zeros); i++ {
			moves += abs(zeros[i].x-perm[i].x) + abs(zeros[i].y-perm[i].y)
		}
		if moves < minMoves {
			minMoves = moves
		}
	})

	return minMoves
}

func permute(arr []struct{ x, y int }, l int, callback func([]struct{ x, y int })) {
	if l == len(arr) {
		callback(arr)
		return
	}
	for i := l; i < len(arr); i++ {
		arr[l], arr[i] = arr[i], arr[l]
		permute(arr, l+1, callback)
		arr[l], arr[i] = arr[i], arr[l]
	}
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}