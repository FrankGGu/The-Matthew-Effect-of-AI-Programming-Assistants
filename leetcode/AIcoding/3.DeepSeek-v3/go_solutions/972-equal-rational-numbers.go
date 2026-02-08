func isRationalEqual(s string, t string) bool {
    return convert(s) == convert(t)
}

func convert(s string) float64 {
    var num float64
    var i int
    for i < len(s) && s[i] != '(' {
        i++
    }
    if i == len(s) {
        num, _ = strconv.ParseFloat(s, 64)
        return num
    }
    base := s[:i]
    rep := s[i+1 : len(s)-1]
    for j := 0; j < 20; j++ {
        base += rep
    }
    num, _ = strconv.ParseFloat(base, 64)
    return num
}