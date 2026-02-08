import "sort"

func findItinerary(tickets [][]string) []string {
	graph := make(map[string][]string)
	for _, ticket := range tickets {
		graph[ticket[0]] = append(graph[ticket[0]], ticket[1])
	}

	for airport := range graph {
		sort.Strings(graph[airport])
	}

	var itinerary []string
	var dfs func(string)
	dfs = func(airport string) {
		destinations := graph[airport]
		for len(destinations) > 0 {
			nextAirport := destinations[0]
			destinations = destinations[1:]
			graph[airport] = destinations
			dfs(nextAirport)
		}
		itinerary = append([]string{airport}, itinerary...)
	}

	dfs("JFK")
	return itinerary
}