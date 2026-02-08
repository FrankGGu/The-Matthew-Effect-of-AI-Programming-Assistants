func wateringPlants(plants []int, capacity int) int {
	steps := 0
	currCapacity := capacity
	for i := 0; i < len(plants); i++ {
		if currCapacity >= plants[i] {
			steps++
			currCapacity -= plants[i]
		} else {
			steps += i
			steps += i + 1
			currCapacity = capacity - plants[i]
		}
	}
	return steps
}