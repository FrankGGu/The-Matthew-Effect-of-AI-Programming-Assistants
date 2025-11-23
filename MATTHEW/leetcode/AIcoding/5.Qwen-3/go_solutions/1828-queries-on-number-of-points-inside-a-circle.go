package main

func countPoints(points []int, queries []byte) []int {
    res := make([]int, len(queries))
    for i, q := range queries {
        x := int(q)
        y := int(queries[i+1])
        r := int(queries[i+2])
        i += 2
        count := 0
        for j := 0; j < len(points); j += 2 {
            dx := points[j] - x
            dy := points[j+1] - y
            if dx*dx+dy*dy <= r*r {
                count++
            }
        }
        res[i] = count
    }
    return res
}