package main

import (
	"sort"
)

func latestTimeCatchTheBus(buses []int, passengers []int, capacity int) int {
	sort.Ints(buses)
	sort.Ints(passengers)

	passengerArrivalsSet := make(map[int]bool)
	for _, p := range passengers {
		passengerArrivalsSet[p] = true
	}

	pIdx := 0
	var latestPassengerOnLastBus int = -1 

	for i := 0; i < len(buses); i++ {
		busArrivalTime := buses[i]
		currentBusCapacity := capacity

		for pIdx < len(passengers) && passengers[pIdx] <= busArrivalTime && currentBusCapacity > 0 {
			if i == len(buses)-1 {
				latestPassengerOnLastBus = passengers[pIdx]
			}
			pIdx++
			currentBusCapacity--
		}

		if i == len(buses)-1 {
			if currentBusCapacity > 0 {
				ans := busArrivalTime
				for passengerArrivalsSet[ans] {
					ans--
				}
				return ans
			} else {
				ans := latestPassengerOnLastBus - 1
				for passengerArrivalsSet[ans] {
					ans--
				}
				return ans
			}
		}
	}

	return -1 
}