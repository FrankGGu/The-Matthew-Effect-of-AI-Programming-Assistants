func incrementalMemoryLeak(memory1 int, memory2 int) []int {
	i := 1
	for {
		if memory1 >= memory2 {
			if memory1 >= i {
				memory1 -= i
			} else {
				break
			}
		} else {
			if memory2 >= i {
				memory2 -= i
			} else {
				break
			}
		}
		i++
	}
	return []int{i, memory1, memory2}
}