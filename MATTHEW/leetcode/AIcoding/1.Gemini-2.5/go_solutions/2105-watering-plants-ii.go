func minimumRefills(plants []int, capacityA int, capacityB int) int {
	refills := 0
	currentA := capacityA
	currentB := capacityB
	left := 0
	right := len(plants) - 1

	for left <= right {
		if left == right { // Middle plant
			//