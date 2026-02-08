func maxValue(n string, x int) string {
    negative := n[0] == '-'
    res := make([]byte, 0, len(n)+1)
    inserted := false

    for i := 0; i < len(n); i++ {
        c := n[i]
        if !inserted {
            if negative && i > 0 {
                if int(c-'0') > x {
                    res = append(res, byte(x+'0'))
                    inserted = true
                }
            } else if !negative {
                if int(c-'0') < x {
                    res = append(res, byte(x+'0'))
                    inserted = true
                }
            }
        }
        res = append(res, c)
    }

    if !inserted {
        res = append(res, byte(x+'0'))
    }

    return string(res)
}