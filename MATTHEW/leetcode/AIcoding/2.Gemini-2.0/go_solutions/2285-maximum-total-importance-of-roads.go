import "sort"

func maximumImportance(n int, roads [][]int) int64 {
	degrees := make([]int, n)
	for _, road := range roads {
		degrees[road[0]]++
		degrees[road[1]]++
	}

	sort.Ints(degrees)

	var totalImportance int64
	for i := 0; i < n; i++ {
		totalImportance += int64(degrees[i]) * int64(i+1)
	}

	return totalImportance
}