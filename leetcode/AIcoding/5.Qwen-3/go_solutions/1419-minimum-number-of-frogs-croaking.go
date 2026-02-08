package main

func minNumberOfFrogsCroaking(croakString string) int {
    count := make(map[rune]int)
    croak := []rune("croak")
    for _, c := range croak {
        count[c] = 0
    }
    for _, c := range croakString {
        if c == 'c' {
            count[c]++
            if count['c'] > count['r'] || count['c'] > count['o'] || count['c'] > count['a'] || count['c'] > count['k'] {
                return -1
            }
        } else {
            if count[c] == 0 {
                return -1
            }
            count[c]--
            if c == 'k' {
                count['c']++
            }
        }
    }
    if count['c'] != 0 || count['r'] != 0 || count['o'] != 0 || count['a'] != 0 {
        return -1
    }
    return count['k']
}