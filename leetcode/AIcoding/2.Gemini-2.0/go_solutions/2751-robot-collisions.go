import (
	"sort"
)

func robotCollisions(directions string, healths []int, positions []int) []int {
	n := len(healths)
	robots := make([]int, n)
	for i := 0; i < n; i++ {
		robots[i] = i
	}

	sort.Slice(robots, func(i, j int) bool {
		return positions[robots[i]] < positions[robots[j]]
	})

	stack := []int{}
	remaining := []int{}

	for _, i := range robots {
		if directions[i] == 'R' {
			stack = append(stack, i)
		} else {
			for len(stack) > 0 {
				j := stack[len(stack)-1]
				if healths[i] > healths[j] {
					healths[i]--
					healths[j] = 0
					stack = stack[:len(stack)-1]
				} else if healths[i] < healths[j] {
					healths[i] = 0
					healths[j]--
					break
				} else {
					healths[i] = 0
					healths[j] = 0
					stack = stack[:len(stack)-1]
					break
				}
			}
			if healths[i] > 0 {
				remaining = append(remaining, i)
			}
		}
	}

	for len(stack) > 0 {
		remaining = append(remaining, stack[len(stack)-1])
		stack = stack[:len(stack)-1]
	}

	sort.Ints(remaining)

	result := make([]int, 0)
	for _, i := range remaining {
		result = append(result, healths[i])
	}

	return result
}