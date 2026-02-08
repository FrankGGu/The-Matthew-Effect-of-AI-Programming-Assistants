func isIsomorphic(s string, t string) bool {
    if len(s) != len(t) {
        return false
    }
    sToT := make(map[byte]byte)
    tToS := make(map[byte]byte)

    for i := 0; i < len(s); i++ {
        sChar := s[i]
        tChar := t[i]

        if mappedT, ok := sToT[sChar]; ok {
            if mappedT != tChar {
                return false
            }
        } else {
            sToT[sChar] = tChar
        }

        if mappedS, ok := tToS[tChar]; ok {
            if mappedS != sChar {
                return false
            }
        } else {
            tToS[tChar] = sChar
        }
    }
    return true
}