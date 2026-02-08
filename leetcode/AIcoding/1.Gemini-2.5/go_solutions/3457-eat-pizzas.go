package main

import (
	"sort"
)

func eatPizzas(pizzas []int, k int) int {
	if k >= len(pizzas) {
		maxPizzaTime := 0
		for _, p := range pizzas {
			if p > maxPizzaTime {
				maxPizzaTime = p
			}
		}
		return maxPizzaTime
	}

	low := 0
	high := 0
	for _, p := range pizzas {
		if p > low {
			low = p
		}
		high += p
	}

	ans := high

	for low <= high {
		mid := low + (high-low)/2
		if canEatAll(pizzas, k, mid) {
			ans = mid
			high = mid - 1
		} else {
			low = mid + 1
		}
	}

	return ans
}

func canEatAll(pizzas []int, k int, maxTime int) bool {
	friendsNeeded := 1
	currentFriendTime := 0

	for _, pizzaTime := range pizzas {
		if pizzaTime > maxTime {
			return false
		}

		if currentFriendTime+pizzaTime <= maxTime {
			currentFriendTime += pizzaTime
		} else {
			friendsNeeded++
			currentFriendTime = pizzaTime
		}
	}

	return friendsNeeded <= k
}