type RowInfo struct {
	soldiers int
	index    int
}

func kWeakestRows(mat [][]int, k int) []int {
	rowsInfo := make([]RowInfo, len