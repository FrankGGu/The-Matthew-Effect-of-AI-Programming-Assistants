package main

func queries(nums []string, queries []string) []int {
    var result []int
    var lastVisited []string
    for _, q := range queries {
        if q == "lastVisited" {
            if len(lastVisited) > 0 {
                result = append(result, len(lastVisited))
            } else {
                result = append(result, 0)
            }
        } else {
            lastVisited = append(lastVisited, q)
        }
    }
    return result
}