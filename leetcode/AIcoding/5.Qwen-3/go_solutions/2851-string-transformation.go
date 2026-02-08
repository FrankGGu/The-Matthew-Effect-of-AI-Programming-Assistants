package main

func strTransform(s string, t string) bool {
    if len(s) != len(t) {
        return false
    }
    mapS := make(map[byte]byte)
    mapT := make(map[byte]byte)
    for i := 0; i < len(s); i++ {
        sc := s[i]
        tc := t[i]
        if val, ok := mapS[sc]; ok {
            if val != tc {
                return false
            }
        } else {
            if _, ok := mapT[tc]; ok {
                return false
            }
            mapS[sc] = tc
            mapT[tc] = sc
        }
    }
    return true
}