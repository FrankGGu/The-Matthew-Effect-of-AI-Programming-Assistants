func sortByHeight(people []string, heights []int) []string {
    type person struct {
        name   string
        height int
    }

    var p []person
    for i := 0; i < len(people); i++ {
        p = append(p, person{name: people[i], height: heights[i]})
    }

    sort.Slice(p, func(i, j int) bool {
        return p[i].height < p[j].height
    })

    result := make([]string, len(p))
    for i, person := range p {
        result[i] = person.name
    }

    return result
}