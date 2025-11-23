package main

func findTheDistanceValue(arr1 []int, arr2 []int, d int) int {
	distanceValue := 0

	for _, num1 := range arr1 {
		isValid := true
		for _, num2 := range arr2 {
			diff := num1 - num2
			if diff < 0 {
				diff = -diff
			}

			if diff <= d {
				isValid = false
				break
			}
		}
		if isValid {
			distanceValue++
		}
	}

	return distanceValue
}