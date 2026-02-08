func customSortString(order string, s string) string {
    orderMap := make(map[byte]int)
    for i := 0; i < len(order); i++ {
        orderMap[order[i]] = i
    }

    sBytes := []byte(s)
    sort.Slice(sBytes, func(i, j int) bool {
        return orderMap[sBytes[i]] < orderMap[sBytes[j]]
    })

    return string(sBytes)
}