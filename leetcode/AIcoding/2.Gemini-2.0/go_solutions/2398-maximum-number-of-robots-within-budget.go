func maximumRobots(costs []int, batteries []int, budget int64) int {
    n := len(costs)
    ans := 0
    l := 0
    sum := 0
    q := []int{}
    for r := 0; r < n; r++ {
        sum += batteries[r]
        for len(q) > 0 && costs[q[len(q)-1]] <= costs[r] {
            q = q[:len(q)-1]
        }
        q = append(q, r)

        for int64(costs[q[0]])+int64(sum) > budget {
            sum -= batteries[l]
            if q[0] == l {
                q = q[1:]
            }
            l++
        }
        ans = max(ans, r-l+1)
    }
    return ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}