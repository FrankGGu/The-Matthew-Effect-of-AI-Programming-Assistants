package main

func sortPeople(names []string, heights []int) []string {
    people := make([][2]string, len(names))
    for i := range names {
        people[i] = [2]string{names[i], strconv.Itoa(heights[i])}
    }
    sort.Slice(people, func(i, j int) bool {
        return people[i][1] > people[j][1]
    })
    result := make([]string, len(names))
    for i := range people {
        result[i] = people[i][0]
    }
    return result
}