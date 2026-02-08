package main

func freqAlphabets(s string) string {
    var result []byte
    i := 0
    for i < len(s) {
        if i+2 < len(s) && s[i+2] == '#' {
            num, _ := strconv.Atoi(s[i:i+2])
            result = append(result, byte('a'+num-1))
            i += 3
        } else {
            num, _ := strconv.Atoi(string(s[i]))
            result = append(result, byte('a'+num-1))
            i++
        }
    }
    return string(result)
}