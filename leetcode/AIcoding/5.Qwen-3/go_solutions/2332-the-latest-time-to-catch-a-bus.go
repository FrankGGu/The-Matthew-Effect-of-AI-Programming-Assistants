package main

func latestTimeCatchBus(buses []int, passengers []int, capacity int) int {
	sort.Ints(buses)
	sort.Ints(passengers)

	i := 0
	for _, bus := range buses {
		cap := capacity
		for i < len(passengers) && passengers[i] <= bus && cap > 0 {
			i++
			cap--
		}
	}

	if i == 0 {
		return buses[0]
	}

	if i < len(passengers) && passengers[i] == buses[len(buses)-1] {
		return passengers[i-1] - 1
	}

	return buses[len(buses)-1]
}