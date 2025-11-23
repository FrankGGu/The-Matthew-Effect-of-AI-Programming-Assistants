import (
	"sort"
)

type Car struct {
	Position int
	Time     float64
}

func carFleet(target int, position []int, speed []int) int {
	if len(position) == 0 {
		return 0
	}

	cars := make([]Car, len(position))
	for i := 0; i < len(position); i++ {
		cars[i] = Car{
			Position: position[i],
			Time:     float64(target-position[i]) / float64(speed[i]),
		}
	}

	sort.Slice(cars, func(i, j int) bool {
		return cars[i].Position > cars[j].Position
	})

	res := 1
	prevTime := cars[0].Time
	for i := 1; i < len(cars); i++ {
		if cars[i].Time > prevTime {
			res++
			prevTime = cars[i].Time
		}
	}

	return res
}