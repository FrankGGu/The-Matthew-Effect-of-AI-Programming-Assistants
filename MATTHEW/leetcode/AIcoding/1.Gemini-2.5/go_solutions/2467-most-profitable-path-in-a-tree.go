package main

import (
	"math"
)

var (
	globalAdj         [][]int
	globalAmount      []int
	globalBobPathTime map[int]int
	globalMaxProfit   int
)

func mostProfitablePath(n int, edges [][]int, bob int, amounts []int) int {
	globalAmount = amounts
	globalAdj = make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		globalAdj[u] = append(globalAdj[u], v)
		globalAdj[v] = append(globalAdj[v], u)
	}

	globalBobPathTime = make(map[int]int)
	findBobPath(0, -1, 0, bob)

	globalMaxProfit = math.MinInt32
	dfsAlice(0, -1, 0, 0)

	return globalMaxProfit
}

func findBobPath(u, p, t, targetBob int) bool {
	if u == targetBob {
		globalBobPathTime[u] = t
		return true
	}

	for _, v := range globalAdj[u] {
		if v == p {
			continue
		}
		if findBobPath(v, u, t+1, targetBob) {
			globalBobPathTime[u] = t
			return true
		}
	}
	return false
}

func dfsAlice(u, p, aliceTime, currentProfit int) {
	nodeValue := globalAmount[u]

	if bobArrivalTime, ok := globalBobPathTime[u]; ok {
		if aliceTime == bobArrivalTime {
			nodeValue /= 2
		} else if aliceTime > bobArrivalTime {
			nodeValue = 0
		}
	}

	currentProfit += nodeValue

	isLeaf := true
	for _, v := range globalAdj[u] {
		if v == p {
			continue
		}
		isLeaf = false
		dfsAlice(v, u, aliceTime+1, currentProfit)
	}

	if isLeaf {
		if currentProfit > globalMaxProfit {
			globalMaxProfit = currentProfit
		}
	}
}