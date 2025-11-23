func minDeletionSize(strs []string) int {
	if len(strs) == 0 {
		return 0
	}

	rows := len(strs)
	cols := len(strs[0])
	deletedColumns := 0

	for j := 0; j < cols; j++ {
		for i := 0; i < rows-1; i++ {
			if strs[i][j] > strs[i+1][j] {
				deletedColumns++
				break
			}
		}
	}

	return deletedColumns
}