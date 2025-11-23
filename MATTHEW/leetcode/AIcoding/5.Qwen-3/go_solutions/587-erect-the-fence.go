package main

func outerTrees(points [][]int) [][]int {
    if len(points) <= 1 {
        return points
    }

    sort.Slice(points, func(i, j int) bool {
        if points[i][0] != points[j][0] {
            return points[i][0] < points[j][0]
        }
        return points[i][1] < points[j][1]
    })

    var upper, lower []int

    for _, p := range points {
        for len(lower) >= 2 && cross(lower[len(lower)-2], lower[len(lower)-1], p) < 0 {
            lower = lower[:len(lower)-1]
        }
        lower = append(lower, p[0], p[1])
    }

    for len(upper) >= 2 && cross(upper[len(upper)-2], upper[len(upper)-1], points[len(points)-1]) > 0 {
        upper = upper[:len(upper)-1]
    }

    for i := len(points) - 1; i >= 0; i-- {
        p := points[i]
        for len(upper) >= 2 && cross(upper[len(upper)-2], upper[len(upper)-1], p) > 0 {
            upper = upper[:len(upper)-1]
        }
        upper = append(upper, p[0], p[1])
    }

    seen := make(map[[2]int]bool)
    result := [][]int{}

    for i := 0; i < len(lower); i += 2 {
        p := [2]int{lower[i], lower[i+1]}
        if !seen[p] {
            seen[p] = true
            result = append(result, []int{p[0], p[1]})
        }
    }

    for i := 0; i < len(upper); i += 2 {
        p := [2]int{upper[i], upper[i+1]}
        if !seen[p] {
            seen[p] = true
            result = append(result, []int{p[0], p[1]})
        }
    }

    return result
}

func cross(o, a, b []int) int {
    return (a[0]-o[0])*(b[1]-o[1]) - (a[1]-o[1])*(b[0]-o[0])
}