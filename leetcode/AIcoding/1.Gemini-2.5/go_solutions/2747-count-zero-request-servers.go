package main

import (
	"sort"
)

type event struct {
	time      int
	eventType int // 0 for request, 1 for query
	id        int // server ID for request, original query index for query
}

func countZeroRequestServers(n int, requests [][]int, queries [][]int) []int {
	events := make([]event, 0, len(requests)+len(queries))

	for _, req := range requests {
		serverID := req[0]
		time := req[1]
		events = append(events, event{time: time, eventType: 0, id: serverID})
	}

	for i, q := range queries {
		time := q[0]
		events = append(events, event{time: time, eventType: 1, id: i})
	}

	sort.Slice(events, func(i, j int) bool {
		if events[i].time != events[j].time {
			return events[i].time < events[j].time
		}
		return events[i].eventType < events[j].eventType
	})

	ans := make([]int, len(queries))

	serverRequestCount := make([]int, n+1) // Server IDs are 1-indexed

	zeroRequestServersCount := n

	for _, e := range events {
		if e.eventType == 0 { // This is a request
			serverID := e.id
			if serverRequestCount[serverID] == 0 {
				zeroRequestServersCount--
			}
			serverRequestCount[serverID]++
		} else { // This is a query
			queryIndex := e.id
			ans[queryIndex] = zeroRequestServersCount
		}
	}

	return ans
}