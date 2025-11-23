import "math"

func garbageCollection(garbage []string, travel []int) int {
	lastM := -1
	lastP := -1
	lastG := -1
	totalM := 0
	totalP := 0
	totalG := 0

	for i, g := range garbage {
		for _, c := range g {
			switch c {
			case 'M':
				totalM++
				lastM = i
			case 'P':
				totalP++
				lastP = i
			case 'G':
				totalG++
				lastG = i
			}
		}
	}

	travelM := 0
	travelP := 0
	travelG := 0

	for i := 0; i < len(travel); i++ {
		if i < int(math.Max(float64(lastM-1), 0.0)) {
			travelM += travel[i]
		}
		if i < int(math.Max(float64(lastP-1), 0.0)) {
			travelP += travel[i]
		}
		if i < int(math.Max(float64(lastG-1), 0.0)) {
			travelG += travel[i]
		}
	}

	return totalM + totalP + totalG + travelM + travelP + travelG
}