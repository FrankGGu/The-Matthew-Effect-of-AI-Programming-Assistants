package main

import (
	"sort"
)

func findItinerary(tickets [][]string) []string {
	adj := make(map[string][]string)
	for _, ticket := range tickets {
		from, to := ticket[0], ticket[1]
		adj[from] = append(adj[from], to)
	}

	for from := range adj {
		sort.Strings(adj[from])
	}

	var itinerary []string
	var dfs func(airport string)
	dfs = func(airport string) {
		for len(adj[airport]) > 0 {
			nextAirport := adj[airport][0]
			adj[airport] = adj[airport][1:]
			dfs(nextAirport)
		}
		itinerary = append(itinerary, airport)
	}

	dfs("JFK")

	for i, j := 0, len(itinerary)-1; i < j; i, j = i+1, j-1 {
		itinerary[i], itinerary[j] = itinerary[j], itinerary[i]
	}

	return itinerary
}