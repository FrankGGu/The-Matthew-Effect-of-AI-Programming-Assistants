func getCollisionTimes(cars [][]int) []float64 {
    n := len(cars)
    res := make([]float64, n)
    stack := make([]int, 0)

    for i := n - 1; i >= 0; i-- {
        res[i] = -1.0
        for len(stack) > 0 {
            j := stack[len(stack)-1]
            if cars[i][1] <= cars[j][1] {
                stack = stack[:len(stack)-1]
            } else {
                t := float64(cars[j][0] - cars[i][0]) / float64(cars[i][1] - cars[j][1])
                if res[j] < 0 || t <= res[j] {
                    res[i] = t
                    break
                } else {
                    stack = stack[:len(stack)-1]
                }
            }
        }
        stack = append(stack, i)
    }

    return res
}