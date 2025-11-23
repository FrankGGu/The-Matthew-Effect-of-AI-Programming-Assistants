import "sort"

func volunteerDeployment(finalCnt []int64, totalNum int32, edges [][]int32, plans [][]int32) []int64 {
    n := len(finalCnt)
    adj := make([][]int, n)
    for _, edge := range edges {
        u, v := int(edge[0])-1, int(edge[1])-1
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    coeffs := make([][]int64, n)
    constTerm := make([]int64, n)
    for i := 0; i < n; i++ {
        coeffs[i] = make([]int64, 3)
        coeffs[i][0] = 1
        constTerm[i] = 0
    }

    for i := len(plans) - 1; i >= 0; i-- {
        idx, change := int(plans[i][0]), int(plans[i][1])
        target := int(plans[i][2]) - 1

        if idx == 1 {
            coeffs[target][0] += int64(change)
        } else if idx == 2 {
            coeffs[target][1] += int64(change)
        } else {
            coeffs[target][2] += int64(change)
        }

        constTerm[target] += int64(change)
    }

    a := int64(1)
    b := int64(0)
    c := int64(0)
    sum := int64(0)
    for i := 0; i < n; i++ {
        a += coeffs[i][0]
        b += coeffs[i][1]
        c += coeffs[i][2]
        sum += finalCnt[i] + constTerm[i]
    }

    x2 := (sum - b - 2*c) / a
    if (sum - b - 2*c) % a != 0 {
        x2 = (sum - b - 2*c + a)/a
    }

    res := make([]int64, n)
    for i := 0; i < n; i++ {
        res[i] = coeffs[i][0]*x2 + coeffs[i][1] + coeffs[i][2]*2 - constTerm[i]
    }

    if x2 < 0 {
        sort.Slice(res, func(i, j int) bool {
            return res[i] < res[j]
        })

        diff := -res[0]
        x2 += diff
        for i := 0; i < n; i++ {
            res[i] += diff
        }

    }

    currentSum := int64(0)
    for i := 0; i < n; i++ {
        currentSum += res[i]
    }

    diff := int64(totalNum) - currentSum
    x2 += diff/int64(n)

        for i := 0; i < n; i++ {
        res[i] = coeffs[i][0]*x2 + coeffs[i][1] + coeffs[i][2]*2 - constTerm[i]
    }

    return res
}