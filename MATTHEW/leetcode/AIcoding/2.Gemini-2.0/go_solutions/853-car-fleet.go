import "sort"

func carFleet(target int, position []int, speed []int) int {
	cars := make([][]int, len(position))
	for i := range position {
		cars[i] = []int{position[i], speed[i]}
	}

	sort.Slice(cars, func(i, j int) bool {
		return cars[i][0] < cars[j][0]
	})

	var fleets int
	var stack []float64

	for i := len(cars) - 1; i >= 0; i-- {
		pos := cars[i][0]
		spd := cars[i][1]
		time := float64(target-pos) / float64(spd)

		if len(stack) == 0 || time > stack[len(stack)-1] {
			fleets++
			stack = append(stack, time)
		}
	}

	return fleets
}