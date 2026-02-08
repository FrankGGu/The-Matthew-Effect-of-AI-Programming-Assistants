package main

func defangIPaddr(address string) string {
    result := ""
    for _, c := range address {
        if c == '.' {
            result += "[.]"
        } else {
            result += string(c)
        }
    }
    return result
}