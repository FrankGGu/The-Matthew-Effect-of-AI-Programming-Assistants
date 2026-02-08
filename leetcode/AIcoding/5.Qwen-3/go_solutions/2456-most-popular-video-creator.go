package main

func mostPopularVideoCreator(creator []string, video []string, startEnd []string) []string {
    popularity := make(map[string]int)
    first := make(map[string]string)
    for i := 0; i < len(creator); i++ {
        c := creator[i]
        v := video[i]
        s := startEnd[i]
        if _, ok := first[c]; !ok {
            first[c] = v
        }
        popularity[c] += 1
    }

    maxPopularity := 0
    var result []string
    for c, p := range popularity {
        if p > maxPopularity {
            maxPopularity = p
            result = []string{c}
        } else if p == maxPopularity {
            result = append(result, c)
        }
    }

    sort.Strings(result)
    return result
}