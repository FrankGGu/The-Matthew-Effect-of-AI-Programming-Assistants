func twoEditWords(queries []string, dictionary []string) []string {
    var res []string
    for _, q := range queries {
        for _, d := range dictionary {
            if canEdit(q, d) {
                res = append(res, q)
                break
            }
        }
    }
    return res
}

func canEdit(a, b string) bool {
    if len(a) != len(b) {
        return false
    }
    diff := 0
    for i := 0; i < len(a); i++ {
        if a[i] != b[i] {
            diff++
            if diff > 2 {
                return false
            }
        }
    }
    return true
}