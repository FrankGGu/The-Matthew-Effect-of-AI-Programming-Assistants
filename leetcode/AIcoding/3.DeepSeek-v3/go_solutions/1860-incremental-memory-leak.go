func memLeak(memory1 int, memory2 int) []int {
    time := 1
    for {
        if memory1 >= memory2 {
            if memory1 < time {
                break
            }
            memory1 -= time
        } else {
            if memory2 < time {
                break
            }
            memory2 -= time
        }
        time++
    }
    return []int{time, memory1, memory2}
}