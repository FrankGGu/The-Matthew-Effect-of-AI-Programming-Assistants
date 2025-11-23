package main

import (
	"fmt"
	"sort"
	"strconv"
)

func latestTimeToCatchBus(buses []int, passengers []int, capacity int) int {
	sort.Ints(buses)
	sort.Ints(passengers)

	n, m := len(buses), len(passengers)
	passengerIndex, latestTime := 0, 0

	for _, bus := range buses {
		count := 0

		for count < capacity && passengerIndex < m && passengers[passengerIndex] <= bus {
			count++
			passengerIndex++
		}

		if count < capacity {
			latestTime = bus
		} else if passengerIndex > 0 && passengers[passengerIndex-1] < bus {
			latestTime = passengers[passengerIndex-1]
		} else {
			latestTime = bus - 1
		}
	}

	for latestTime > 0 {
		if passengerIndex > 0 && latestTime == passengers[passengerIndex-1] {
			latestTime--
			passengerIndex--
		} else {
			break
		}
	}

	return latestTime
}

func main() {
	buses := []int{10, 20, 30}
	passengers := []int{5, 10, 15, 20, 25}
	capacity := 2
	fmt.Println(latestTimeToCatchBus(buses, passengers, capacity))
}