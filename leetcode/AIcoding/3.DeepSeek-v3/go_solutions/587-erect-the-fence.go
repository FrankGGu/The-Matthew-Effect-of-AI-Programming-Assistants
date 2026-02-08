func outerTrees(trees [][]int) [][]int {
    if len(trees) <= 1 {
        return trees
    }

    sort.Slice(trees, func(i, j int) bool {
        if trees[i][0] == trees[j][0] {
            return trees[i][1] < trees[j][1]
        }
        return trees[i][0] < trees[j][0]
    })

    n := len(trees)
    hull := make([][]int, 0)

    for i := 0; i < n; i++ {
        for len(hull) >= 2 && cross(hull[len(hull)-2], hull[len(hull)-1], trees[i]) < 0 {
            hull = hull[:len(hull)-1]
        }
        hull = append(hull, trees[i])
    }

    for i := n - 2; i >= 0; i-- {
        for len(hull) >= 2 && cross(hull[len(hull)-2], hull[len(hull)-1], trees[i]) < 0 {
            hull = hull[:len(hull)-1]
        }
        hull = append(hull, trees[i])
    }

    unique := make(map[[2]int]bool)
    res := make([][]int, 0)
    for _, p := range hull {
        key := [2]int{p[0], p[1]}
        if !unique[key] {
            unique[key] = true
            res = append(res, p)
        }
    }

    return res
}

func cross(a, b, c []int) int {
    return (b[0]-a[0])*(c[1]-a[1]) - (b[1]-a[1])*(c[0]-a[0])
}