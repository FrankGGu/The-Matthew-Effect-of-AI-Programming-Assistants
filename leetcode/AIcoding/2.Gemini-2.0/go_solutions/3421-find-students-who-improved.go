func findStudents(content [][]string) []string {
	res := []string{}
	for _, row := range content {
		if row[2] > row[1] {
			res = append(res, row[0])
		}
	}
	return res
}