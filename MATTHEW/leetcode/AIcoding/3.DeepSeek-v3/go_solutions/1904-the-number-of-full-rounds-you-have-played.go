func numberOfRounds(loginTime string, logoutTime string) int {
    parse := func(s string) int {
        hh := int(s[0]-'0')*10 + int(s[1]-'0')
        mm := int(s[3]-'0')*10 + int(s[4]-'0')
        return hh*60 + mm
    }

    start := parse(loginTime)
    end := parse(logoutTime)

    if end < start {
        end += 24 * 60
    }

    start = (start + 14) / 15 * 15
    end = end / 15 * 15

    if start >= end {
        return 0
    }

    return (end - start) / 15
}