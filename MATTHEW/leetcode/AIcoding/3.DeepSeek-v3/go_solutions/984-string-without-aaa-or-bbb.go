func strWithout3a3b(a int, b int) string {
    var res []byte
    for a > 0 || b > 0 {
        writeA := false
        if len(res) >= 2 && res[len(res)-1] == res[len(res)-2] {
            if res[len(res)-1] == 'b' {
                writeA = true
            }
        } else {
            if a > b {
                writeA = true
            }
        }
        if writeA {
            res = append(res, 'a')
            a--
        } else {
            res = append(res, 'b')
            b--
        }
    }
    return string(res)
}