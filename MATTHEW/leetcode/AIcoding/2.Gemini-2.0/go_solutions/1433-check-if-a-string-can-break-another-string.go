import "sort"

func checkIfCanBreak(s1 string, s2 string) bool {
	bs1 := []byte(s1)
	bs2 := []byte(s2)
	sort.Slice(bs1, func(i, j int) bool { return bs1[i] < bs1[j] })
	sort.Slice(bs2, func(i, j int) bool { return bs2[i] < bs2[j] })

	canBreak1 := true
	canBreak2 := true

	for i := 0; i < len(s1); i++ {
		if bs1[i] < bs2[i] {
			canBreak1 = false
		}
		if bs2[i] < bs1[i] {
			canBreak2 = false
		}
	}

	return canBreak1 || canBreak2
}