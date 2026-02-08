package main

func minimumTotalDistance(robot []int, factory []int) int {
	sort.Ints(robot)
	sort.Ints(factory)

	n := len(robot)
	m := len(factory)

	type Factory struct {
		pos  int
		cap  int
	}

	factories := make([]Factory, m)
	for i := 0; i < m; i++ {
		factories[i] = Factory{factory[i], 0}
	}

	for i := 0; i < m; i++ {
		factories[i].cap = 1
	}

	for i := 1; i < m; i++ {
		if factories[i].pos == factories[i-1].pos {
			factories[i-1].cap += factories[i].cap
			factories[i].cap = 0
		}
	}

	for i := m - 2; i >= 0; i-- {
		if factories[i].pos == factories[i+1].pos {
			factories[i].cap += factories[i+1].cap
			factories[i+1].cap = 0
		}
	}

	j := 0
	for i := 0; i < m; i++ {
		if factories[i].cap > 0 {
			factories[j] = factories[i]
			j++
		}
	}
	factories = factories[:j]

	m = j

	dp := make([]int, n)
	for i := 0; i < n; i++ {
		dp[i] = math.MaxInt32
	}

	for i := 0; i < m; i++ {
		factoryPos := factories[i].pos
		factoryCap := factories[i].cap

		newDp := make([]int, n)
		for k := 0; k < n; k++ {
			newDp[k] = dp[k]
		}

		for k := 0; k < n; k++ {
			if k == 0 {
				newDp[k] = abs(robot[k] - factoryPos)
			} else {
				newDp[k] = min(newDp[k], dp[k-1]+abs(robot[k]-factoryPos))
			}
		}

		for k := 1; k < factoryCap; k++ {
			for l := n - 1; l >= 0; l-- {
				if l == 0 {
					newDp[l] = min(newDp[l], abs(robot[l]-factoryPos))
				} else {
					newDp[l] = min(newDp[l], newDp[l-1]+abs(robot[l]-factoryPos))
				}
			}
		}

		dp = newDp
	}

	return dp[n-1]
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}