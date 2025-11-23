func memLeak(memory1 int, memory2 int) []int {
    time := 0
    for memory1 >= time+1 || memory2 >= time+1 {
        if memory1 > memory2 {
            memory1 -= time + 1
        } else {
            memory2 -= time + 1
        }
        time++
    }
    return []int{time, memory1, memory2}
}