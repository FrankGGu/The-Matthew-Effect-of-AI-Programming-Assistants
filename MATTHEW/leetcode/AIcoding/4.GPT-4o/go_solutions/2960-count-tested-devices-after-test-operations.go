func countDevices(devices []int, operations [][]int) []int {
    n := len(devices)
    result := make([]int, len(operations))
    tested := make([]bool, n)

    for i, op := range operations {
        deviceIndex := op[0] - 1
        if op[1] == 1 {
            tested[deviceIndex] = true
        } else {
            tested[deviceIndex] = false
        }

        count := 0
        for _, t := range tested {
            if t {
                count++
            }
        }
        result[i] = count
    }

    return result
}