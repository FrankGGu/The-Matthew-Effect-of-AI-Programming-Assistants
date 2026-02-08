package main

func compareVersionNumbers(version1 string, version2 string) int {
    v1 := strings.Split(version1, ".")
    v2 := strings.Split(version2, ".")

    maxLen := len(v1)
    if len(v2) > maxLen {
        maxLen = len(v2)
    }

    for i := 0; i < maxLen; i++ {
        num1 := 0
        if i < len(v1) {
            num1, _ = strconv.Atoi(v1[i])
        }

        num2 := 0
        if i < len(v2) {
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