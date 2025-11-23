func numTeams(ranked []int) int {
    n := len(ranked)
    count := 0

    for i := 0; i < n; i++ {
        leftLess, leftGreater := 0, 0
        for j := 0; j < n; j++ {
            if ranked[j] < ranked[i] {
                leftLess++
            } else if ranked[j] > ranked[i] {
                leftGreater++
            }
        }
        count += leftLess * (n - i - 1 - leftGreater) + leftGreater * (n - i - 1 - leftLess)
    }

    return count
}