func minimumOperations(nums []int, start int, goal int) int {
    q := []int{start}
    visited := make(map[int]bool)
    visited[start] = true
    steps := 0

    for len(q) > 0 {
        size := len(q)
        for i := 0; i < size; i++ {
            curr := q[0]
            q = q[1:]

            if curr == goal {
                return steps
            }

            for _, num := range nums {
                next := []int{curr + num, curr - num, curr ^ num}
                for _, n := range next {
                    if n >= 0 && n <= 1000 && !visited[n] {
                        q = append(q, n)
                        visited[n] = true
                    }
                }
            }
        }
        steps++
    }

    return -1
}