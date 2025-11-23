func makeLargestSpecial(S string) string {
    count, start, specials := 0, 0, []string{}
    for i := 0; i < len(S); i++ {
        if S[i] == '1' {
            count++
        } else {
            count--
        }
        if count == 0 {
            specials = append(specials, "1"+makeLargestSpecial(S[start+1:i])+"0")
            start = i + 1
        }
    }
    sort.Slice(specials, func(i, j int) bool {
        return specials[i] > specials[j]
    })
    return strings.Join(specials, "")
}