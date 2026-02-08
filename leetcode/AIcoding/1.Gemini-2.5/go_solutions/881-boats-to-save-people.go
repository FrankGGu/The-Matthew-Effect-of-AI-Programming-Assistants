import "sort"

func numRescueBoats(people []int, limit int) int {
	sort.Ints(people)
	boats := 0
	left := 0
	right := len(people) - 1

	for left <= right {
		boats++
		if people[left]+people[right] <= limit {
			left++
		}
		right--
	}

	return boats
}