func wordPattern(pattern string, s string) bool {
    words := strings.Split(s, " ")
    if len(pattern) != len(words) {
        return false
    }

    pToW := make(map[byte]string)
    wToP := make(map[string]byte)

    for i := 0; i < len(pattern); i++ {
        p := pattern[i]
        w := words[i]

        if pw, ok := pToW[p]; ok {
            if pw != w {
                return false
            }
        } else {
            pToW[p] = w
        }

        if wp, ok := wToP[w]; ok {
            if wp != p {
                return false
            }
        } else {
            wToP[w] = p
        }
    }

    return true
}