func sortPeople(names []string, heights []int) []string {
    n := len(names)
    people := make([][2]interface{}, n)
    for i := 0; i < n; i++ {
        people[i] = [2]interface{}{heights[i], names[i]}
    }

    sort.Slice(people, func(i, j int) bool {
        return people[i][0].(int) > people[j][0].(int)
    })

    result := make([]string, n)
    for i := 0; i < n; i++ {
        result[i] = people[i][1].(string)
    }
    return result
}