package main

func isIsomorphic(s string, t string) bool {
    if len(s) != len(t) {
        return false
    }
    sMap := make(map[rune]rune)
    tMap := make(map[rune]rune)
    for i := 0; i < len(s); i++ {
        sChar := rune(s[i])
        tChar := rune(t[i])
        if sMap[sChar] != 0 || tMap[tChar] != 0 {
            if sMap[sChar] != tChar || tMap[tChar] != sChar {
                return false
            }
        } else {
            sMap[sChar] = tChar
            tMap[tChar] = sChar
        }
    }
    return true
}