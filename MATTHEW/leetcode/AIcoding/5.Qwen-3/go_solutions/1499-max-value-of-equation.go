package main

func findMaxValueOfEquation(queries []int, k int) int {
    sort.Slice(queries, func(i, j int) bool {
        return queries[i] < queries[j]
    })
    var maxVal int = math.MinInt32
    var queue []int
    for _, x := range queries {
        for len(queue) > 0 && x-queue[0] > k {
            queue = queue[1:]
        }
        if len(queue) > 0 {
            currentVal := x + queue[0]
            if currentVal > maxVal {
                maxVal = currentVal
            }
        }
        queue = append(queue, x)
    }
    return maxVal
}