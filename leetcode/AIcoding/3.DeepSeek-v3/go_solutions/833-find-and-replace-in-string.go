func findReplaceString(s string, indices []int, sources []string, targets []string) string {
    n := len(indices)
    operations := make([][3]interface{}, n)
    for i := 0; i < n; i++ {
        operations[i] = [3]interface{}{indices[i], sources[i], targets[i]}
    }
    sort.Slice(operations, func(i, j int) bool {
        return operations[i][0].(int) > operations[j][0].(int)
    })
    for _, op := range operations {
        idx := op[0].(int)
        source := op[1].(string)
        target := op[2].(string)
        if idx+len(source) <= len(s) && s[idx:idx+len(source)] == source {
            s = s[:idx] + target + s[idx+len(source):]
        }
    }
    return s
}