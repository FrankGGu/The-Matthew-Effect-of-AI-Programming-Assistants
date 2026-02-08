import "sort"

func latestTimeCatchTheBus(buses []int, passengers []int, capacity int) int {
	sort.Ints(buses)
	sort.Ints(passengers)

	j := 0
	for i := 0; i < len(buses); i++ {
		count := 0
		for j < len(passengers) && passengers[j] <= buses[i] && count < capacity {
			j++
			count++
		}
	}

	ans := buses[len(buses)-1]
	if j == 0 {
		ans++
	} else {
		if (j > 0 && j <= len(passengers)) {
			ans = passengers[j-1]
		} else {
			ans = buses[len(buses)-1]
		}
		ans--
	}

	for {
		found := false
		for i := 0; i < len(passengers); i++ {
			if passengers[i] == ans {
				ans--
				found = true
				break
			}
		}
		if !found {
			break
		}
	}

	return ans
}