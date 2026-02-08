func report(spam []string) []string {
    count := make(map[string]int)
    for _, s := range spam {
        count[s]++
    }

    var res []string
    for s, cnt := range count {
        if cnt >= 2 {
            res = append(res, s)
        }
    }

    sort.Strings(res)
    return res
}