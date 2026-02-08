import "sort"

func kthSmallestPrimeFraction(arr []int, k int) float64 {
	n := len(arr)
	fractions := make([]float64, 0)
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			fractions = append(fractions, float64(arr[i])/float64(arr[j]))
		}
	}
	sort.Float64s(fractions)
	return fractions[k-1]
}