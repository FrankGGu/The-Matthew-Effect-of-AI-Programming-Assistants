func findAllPeople(n int, meetings [][]int, firstPerson int) []int {
    // Sort meetings by time
    sort.Slice(meetings, func(i, j int) bool {
        return meetings[i][2] < meetings[j][2]
    })

    parent := make([]int, n)
    for i := range parent {
        parent[i] = i
    }

    var find func(x int) int
    find = func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    union := func(x, y int) {
        parent[find(x)] = find(y)
    }

    union(0, firstPerson)

    i := 0
    for i < len(meetings) {
        time := meetings[i][2]
        group := make([]int, 0)

        for i < len(meetings) && meetings[i][2] == time {
            group = append(group, meetings[i][0], meetings[i][1])
            i++
        }

        for _, person := range group {
            if find(person) == find(0) {
                for _, p := range group {
                    union(person, p)
                }
                break
            }
        }
    }

    res := []int{}
    for i := 0; i < n; i++ {
        if find(i) == find(0) {
            res = append(res, i)
        }
    }

    sort.Ints(res)
    return res
}