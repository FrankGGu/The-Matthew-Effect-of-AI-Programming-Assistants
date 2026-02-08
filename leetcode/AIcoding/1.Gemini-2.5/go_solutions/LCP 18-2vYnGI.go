import (
	"sort"
)

func breakfastNumber(staple []int, price []int, x int) int {
	sort.Ints(staple)

	count := 0
	mod := 1_000_000_007

	for _, p := range price {
		targetStaple := x - p
		if targetStaple < staple[0] { // Optimization: if current price + smallest staple already exceeds x, no need to search
			continue
		}

		// Find the count of staple items 's' such that s <= targetStaple.
		// sort.SearchInts(arr, val) returns the index of the first element >= val.
		// To find elements <= targetStaple, we search for the first element > targetStaple.
		// The index returned by sort.SearchInts(staple, targetStaple + 1) gives the count of elements <= targetStaple.
		idx := sort.SearchInts(staple, targetStaple+1)

		count = (count + idx) % mod
	}

	return count
}