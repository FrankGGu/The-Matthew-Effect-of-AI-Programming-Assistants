func maxSatisfied(customers []int, grumpy []int, minutes int) int {
	n := len(customers)
	satisfied := 0
	for i := 0; i < n; i++ {
		if grumpy[i] == 0 {
			satisfied += customers[i]
		}
	}

	maxPotential := 0
	currentPotential := 0
	for i := 0; i < n; i++ {
		if grumpy[i] == 1 {
			currentPotential += customers[i]
		}

		if i >= minutes {
			if grumpy[i-minutes] == 1 {
				currentPotential -= customers[i-minutes]
			}
		}

		if currentPotential > maxPotential {
			maxPotential = currentPotential
		}
	}

	return satisfied + maxPotential
}