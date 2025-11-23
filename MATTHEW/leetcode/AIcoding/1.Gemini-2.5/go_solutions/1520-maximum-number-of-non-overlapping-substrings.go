func maxNumOfSubstrings(s string) []string {
	n := len(s)
	left := make([]int, 26)
	right := make([]int, 26)

	for i := 0; i < 2