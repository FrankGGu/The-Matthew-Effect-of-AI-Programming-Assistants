import "sort"

func asteroidsDestroyed(mass int, asteroids []int) bool {
	sort.Ints(asteroids)
	for _, asteroid := range asteroids {
		if mass >= asteroid {
			mass += asteroid
		} else {
			return false
		}
	}
	return true
}