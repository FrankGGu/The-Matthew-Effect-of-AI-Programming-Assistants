package main

func reachNumber(target int) int {
	if target < 0 {
		target = -target
	}

	k := 0
	sum := 0
	for {
		k++
		sum += k
		if sum >= target && (sum-target)%2 == 0 {
			return k
		}
	}
}