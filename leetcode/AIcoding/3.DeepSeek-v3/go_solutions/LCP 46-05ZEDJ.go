func volunteerDeployment(finalCnt []int, totalNum int64, edges [][]int, plans [][]int) []int {
    n := len(finalCnt) + 1
    adj := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    coeff := make([]int, n)
    const := make([]int64, n)
    coeff[0] = 1
    const[0] = 0

    for i := 1; i < n; i++ {
        coeff[i] = 0
        const[i] = int64(finalCnt[i-1])
    }

    for i := len(plans) - 1; i >= 0; i-- {
        plan := plans[i]
        idx := plan[1]
        switch plan[0] {
        case 1:
            coeff[idx] *= 2
            const[idx] *= 2
        case 2:
            for _, neighbor := range adj[idx] {
                coeff[neighbor] -= coeff[idx]
                const[neighbor] -= const[idx]
            }
        case 3:
            for _, neighbor := range adj[idx] {
                coeff[neighbor] += coeff[idx]
                const[neighbor] += const[idx]
            }
        }
    }

    sumCoeff := int64(0)
    sumConst := int64(0)
    for i := 0; i < n; i++ {
        sumCoeff += int64(coeff[i])
        sumConst += const[i]
    }

    x := (totalNum - sumConst) / sumCoeff
    res := make([]int, n)
    for i := 0; i < n; i++ {
        res[i] = int(int64(coeff[i])*x + const[i])
    }
    return res
}