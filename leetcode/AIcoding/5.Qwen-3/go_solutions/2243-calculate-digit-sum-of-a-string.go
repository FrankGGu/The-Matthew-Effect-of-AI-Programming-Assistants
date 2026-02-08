package main

func digitSum(s string, k int) string {
    for len(s) > k {
        var newS string
        for i := 0; i < len(s); i += k {
            end := i + k
            if end > len(s) {
                end = len(s)
            }
            substring := s[i:end]
            sum := 0
            for _, c := range substring {
                sum += int(c - '0')
            }
            newS += strconv.Itoa(sum)
        }
        s = newS
    }
    return s
}