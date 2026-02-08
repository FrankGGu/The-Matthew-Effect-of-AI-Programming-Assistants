package main

import "math"

func fillMissingData(data [][]int) [][]int {
	if data == nil || len(data) == 0 {
		return data
	}

	for i := 0; i < len(data); i++ {
		row := data[i]
		sum := 0
		count := 0
		missingCount := 0

		for j := 0; j < len(row); j++ {
			if row[j] != -1 {
				sum += row[j]
				count++
			} else {
				missingCount++
			}
		}

		if missingCount > 0 {
			var avg int
			if count > 0 {
				avg = int(math.Round(float64(sum) / float64(count)))
			} else {
				avg = 0
			}

			for j := 0; j < len(row); j++ {
				if row[j] == -1 {
					data[i][j] = avg
				}
			}
		}
	}
	return data
}