package main

func backspaceCompare(s string, t string) bool {
    i := len(s) - 1
    j := len(t) - 1

    for i >= 0 || j >= 0 {
        skipS := 0
        for i >= 0 {
            if s[i] == '#' {
                skipS++
                i--
            } else if skipS > 0 {
                skipS--
                i--
            } else {
                break
            }
        }

        skipT := 0
        for j >= 0 {
            if t[j] == '#' {
                skipT++
                j--
            } else if skipT > 0 {
                skipT--
                j--
            } else {
                break
            }
        }

        if i >= 0 && j >= 0 {
            if s[i] != t[j] {
                return false
            }
        } else if (i >= 0) != (j >= 0) {
            return false
        }

        i--
        j--
    }

    return true
}