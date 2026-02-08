package main

func countStudents(strudents []int, sandwiches []int) int {
    queue := make([]int, len(strudents))
    copy(queue, strudents)
    i := 0
    for len(queue) > 0 && i < len(sandwiches) {
        if queue[0] == sandwiches[i] {
            queue = queue[1:]
            i++
        } else {
            break
        }
    }
    return len(queue)
}