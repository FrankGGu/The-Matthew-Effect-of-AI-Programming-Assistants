func compareVersion(version1 string, version2 string) int {
    v1 := strings.Split(version1, ".")
    v2 := strings.Split(version2, ".")
    n1, n2 := len(v1), len(v2)

    for i := 0; i < max(n1, n2); i++ {
        var num1, num2 int
        if i < n1 {
            num1, _ = strconv.Atoi(v1[i])
        }
        if i < n2 {
            num2, _ = strconv.Atoi(v2[i])
        }
        if num1 < num2 {
            return -1
        } else if num1 > num2 {
            return 1
        }
    }
    return 0
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}