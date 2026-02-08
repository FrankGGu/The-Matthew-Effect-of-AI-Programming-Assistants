func strWithout3a3b(A int, B int) string {
    result := ""
    for A > 0 || B > 0 {
        if A > B {
            if A > 1 {
                result += "aab"
                A -= 2
                B -= 1
            } else {
                result += "a"
                A--
            }
        } else {
            if B > 1 {
                result += "bba"
                B -= 2
                A -= 1
            } else {
                result += "b"
                B--
            }
        }
    }
    return result
}