func minStalls(customers []string) int {
	starts := make([]int, 0)
	ends := make([]int, 0)

	for _, customer := range customers {
		times := strings.Split(customer, "-")
		start, _ := strconv.Atoi(times[0])
		end, _ := strconv.Atoi(times[1])
		starts = append(starts, start)
		ends = append(ends, end)
	}

	sort.Ints(starts)
	sort.Ints(ends)

	stalls := 0
	j := 0
	for i := 0; i < len(starts); i++ {
		if starts[i] > ends[j] {
			j++
		} else {
			stalls++
		}
	}

	return stalls
}