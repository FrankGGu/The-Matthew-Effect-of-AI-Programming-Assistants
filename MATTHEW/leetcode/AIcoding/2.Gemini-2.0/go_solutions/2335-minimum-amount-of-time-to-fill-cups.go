import "sort"

func fillCups(amount []int) int {
	sort.Ints(amount)
	a, b, c := amount[0], amount[1], amount[2]
	if a+b <= c {
		return c
	}
	return (a + b + c + 1) / 2
}