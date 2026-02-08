package main

func strWithout3a3b(a int, b int) string {
    var result []rune
    for a > 0 || b > 0 {
        if a > b {
            result = append(result, 'a')
            a--
            if a > 0 {
                result = append(result, 'a')
                a--
            }
        } else {
            result = append(result, 'b')
            b--
            if b > 0 {
                result = append(result, 'b')
                b--
            }
        }
    }
    return string(result)
}