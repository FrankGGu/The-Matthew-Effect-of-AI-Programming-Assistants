func minInsertions(s string) int {
    res, need := 0, 0
    for i := 0; i < len(s); i++ {
        if s[i] == '(' {
            need += 2
            if need % 2 == 1 {
                res++
                need--
            }
        } else {
            need--
            if need == -1 {
                res++
                need = 1
            }
        }
    }
    return res + need
}