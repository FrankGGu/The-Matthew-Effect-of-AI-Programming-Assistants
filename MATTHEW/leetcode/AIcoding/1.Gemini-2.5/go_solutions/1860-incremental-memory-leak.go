func memLeak(memory1 int, memory2 int) []int {
    i := 1
    for {
        if memory1 >= memory2 {
            if memory1 < i {
                return []int{i, memory1, memory2}
            }
            memory1 -= i
        } else { // memory2 >