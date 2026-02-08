package main

func reconstructQueue(people [][]int) [][]int {
    sort.Slice(people, func(i, j int) bool {
        if people[i][0] != people[j][0] {
            return people[i][0] > people[j][0]
        }
        return people[i][1] < people[j][1]
    })

    result := make([][]int, 0)
    for _, p := range people {
        result = append(result, p)
        if p[1] < len(result)-1 {
            result = append(result[:p[1]+1], result[p[1]+1:]...)
        }
    }

    return result
}