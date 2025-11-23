package main

import (
	"sort"
)

func findItinerary(tickets [][]string) []string {
	graph := make(map[string][]string)
	for _, ticket := range tickets {
		graph[ticket[0]] = append(graph[ticket[0]], ticket[1])
	}
	for k := range graph {
		sort.Strings(graph[k])
	}

	var result []string
	var dfs func(string) bool
	dfs = func(airport string) bool {
		if len(result) == len(tickets)+1 {
			return true
		}
		if destinations, ok := graph[airport]; ok {
			for i := 0; i < len(destinations); i++ {
				if destinations[i] != "" {
					next := destinations[i]
					graph[airport][i] = ""
					if dfs(next) {
						result = append([]string{airport}, result...)
						return true
					}
					graph[airport][i] = next
				}
			}
		}
		return false
	}

	dfs("JFK")
	return append(result, "JFK")
}