package main

func maximumNumber(num string, change []int) string {
    s := []byte(num)
    n := len(s)
    i := 0
    for i < n && s[i] == '0' {
        i++
    }
    if i == n {
        return "0"
    }
    for i < n {
        if int(s[i]-'0') < change[int(s[i]-'0')] {
            s[i] = byte(change[int(s[i]-'0')] + '0')
            i++
        } else {
            break
        }
    }
    return string(s)
}