import "sort"

func breakfastNumber(staple []int, drinks []int, x int) int {
	sort.Ints(staple)
	sort.Ints(drinks)
	count := 0
	j := len(drinks) - 1
	for i := 0; i < len(staple); i++ {
		for j >= 0 && staple[i]+drinks[j] > x {
			j--
		}
		if j >= 0 {
			count = (count + j + 1) % 1000000007
		}
	}
	return count
}