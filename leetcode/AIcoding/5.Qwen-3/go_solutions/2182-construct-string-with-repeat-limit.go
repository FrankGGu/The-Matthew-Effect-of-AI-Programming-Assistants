package main

func repeatLimitedString(s string, repeatLimit int) string {
    counts := make([]int, 26)
    for _, c := range s {
        counts[c-'a']++
    }

    var res []byte
    for i := 0; i < 26; i++ {
        if counts[i] == 0 {
            continue
        }
        j := 0
        for j < counts[i] && i+1 < 26 {
            for k := 0; k < repeatLimit && j < counts[i]; k++ {
                res = append(res, byte('a'+i))
                j++
            }
            if j < counts[i] {
                for l := i+1; l < 26; l++ {
                    if counts[l] > 0 {
                        res = append(res, byte('a'+l))
                        counts[l]--
                        break
                    }
                }
            }
        }
        if j < counts[i] {
            for k := 0; k < repeatLimit && j < counts[i]; k++ {
                res = append(res, byte('a'+i))
                j++
            }
        }
    }
    return string(res)
}