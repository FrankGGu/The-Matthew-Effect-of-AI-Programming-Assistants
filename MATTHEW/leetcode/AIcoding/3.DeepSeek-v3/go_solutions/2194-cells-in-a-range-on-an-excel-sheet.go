func cellsInRange(s string) []string {
    var res []string
    c1, r1 := s[0], s[1]
    c2, r2 := s[3], s[4]

    for c := c1; c <= c2; c++ {
        for r := r1; r <= r2; r++ {
            res = append(res, string(c)+string(r))
        }
    }
    return res
}