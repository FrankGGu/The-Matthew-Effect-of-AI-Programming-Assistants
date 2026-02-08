func backspaceCompare(S string, T string) bool {
    sIndex, tIndex := len(S)-1, len(T)-1
    sSkip, tSkip := 0, 0

    for sIndex >= 0 || tIndex >= 0 {
        for sIndex >= 0 {
            if S[sIndex] == '#' {
                sSkip++
                sIndex--
            } else if sSkip > 0 {
                sSkip--
                sIndex--
            } else {
                break
            }
        }

        for tIndex >= 0 {
            if T[tIndex] == '#' {
                tSkip++
                tIndex--
            } else if tSkip > 0 {
                tSkip--
                tIndex--
            } else {
                break
            }
        }

        if sIndex < 0 && tIndex < 0 {
            return true
        }
        if sIndex < 0 || tIndex < 0 || S[sIndex] != T[tIndex] {
            return false
        }
        sIndex--
        tIndex--
    }

    return true
}