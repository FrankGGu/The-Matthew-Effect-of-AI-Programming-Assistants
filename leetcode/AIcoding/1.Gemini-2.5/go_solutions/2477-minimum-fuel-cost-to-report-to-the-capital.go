package main

func minimumFuelCost(roads [][]int, seats int) int64 {
	n := len(roads) + 1

	adj := make([][]int, n)
	for _, road := range roads {
		u, v := road[0], road[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	var totalFuel int64

	var dfs func(u, p int) int
	dfs = func(u, p int) int {
		people := 1
		for _, v := range adj[u] {
			if v == p {
				continue
			}
			peopleFromChild := dfs(v, u)
			people += peopleFromChild
		}

		if u != 0 {
			carsNeeded := (people + seats - 1) / seats
			totalFuel += int64(carsNeeded)
		}

		return people
	}

	dfs(0, -1)

	return totalFuel
}