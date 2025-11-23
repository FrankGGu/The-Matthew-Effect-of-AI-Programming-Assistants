package main

import (
	"container/list"
)

func numBusesToDestination(routes [][]int, source int, target int) int {
	if source == target {
		return 0
	}

	stopToRoutesMap := make(map[int][]int)
	for routeID, stops := range routes {
		for _, stop := range stops {
			stopToRoutesMap[stop] = append(stopToRoutesMap[stop], routeID)
		}
	}

	type QueueItem struct {
		id      int
		isRoute bool
		buses   int
	}
	q := list.New()

	visitedStops := make(map[int]bool)
	visitedRoutes := make([]bool, len(routes))

	sourceRoutes, exists := stopToRoutesMap[source]
	if !exists {
		return -1
	}

	for _, routeID := range sourceRoutes {
		q.PushBack(QueueItem{id: routeID, isRoute: true, buses: 1})
		visitedRoutes[routeID] = true

		for _, stop := range routes[routeID] {
			if stop == target {
				return 1
			}
		}
	}

	for q.Len() > 0 {
		curr := q.Remove(q.Front()).(QueueItem)

		if curr.isRoute {
			for _, stop := range routes[curr.id] {
				if stop == target {
					return curr.buses
				}
				if !visitedStops[stop] {
					visitedStops[stop] = true
					q.PushBack(QueueItem{id: stop, isRoute: false, buses: curr.buses})
				}
			}
		} else {
			for _, routeID := range stopToRoutesMap[curr.id] {
				if !visitedRoutes[routeID] {
					visitedRoutes[routeID] = true
					q.PushBack(QueueItem{id: routeID, isRoute: true, buses: curr.buses + 1})
				}
			}
		}
	}

	return -1
}