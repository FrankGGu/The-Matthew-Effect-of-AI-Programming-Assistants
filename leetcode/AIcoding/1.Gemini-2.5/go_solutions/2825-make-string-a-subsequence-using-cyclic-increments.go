func canBeSubsequence(str1 string, str2 string) bool {
    p1 := 0
    p2 := 0

    for p1 < len(str1) && p2 < len(str2) {
        char1 := str1[p1]
        char2 := str2[p2