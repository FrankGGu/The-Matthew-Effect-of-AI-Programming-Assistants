func smallestGoodBase(n string) string {
	nVal, _ := strconv.ParseUint(n, 10, 64)

	// Iterate through possible number of digits 'm' in base k.
	// m ranges from max possible (when