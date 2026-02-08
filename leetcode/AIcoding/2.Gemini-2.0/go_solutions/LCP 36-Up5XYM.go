import (
	"sort"
)

func maxNumberOfFamilies(n int, reservedSeats [][]int) int {
	reserved := make(map[int][]int)
	for _, seat := range reservedSeats {
		row := seat[0]
		col := seat[1]
		reserved[row] = append(reserved[row], col)
	}

	ans := 2 * n

	for _, cols := range reserved {
		sort.Ints(cols)
	}

	for row, cols := range reserved {
		count := 0
		if len(cols) > 0 {
			ans -= 2
			if !contains(cols, 2) && !contains(cols, 3) && !contains(cols, 4) && !contains(cols, 5) {
				count++
			}
			if !contains(cols, 6) && !contains(cols, 7) && !contains(cols, 8) && !contains(cols, 9) {
				count++
			}

			if count == 0 && !contains(cols, 4) && !contains(cols, 5) && !contains(cols, 6) && !contains(cols, 7){
				if !contains(cols, 2) || !contains(cols, 9){
					count++
				}
			}

			ans += count
		} else {
			reserved[row] = []int{}
		}
	}

	return ans
}

func contains(s []int, e int) bool {
	for _, a := range s {
		if a == e {
			return true
		}
	}
	return false
}