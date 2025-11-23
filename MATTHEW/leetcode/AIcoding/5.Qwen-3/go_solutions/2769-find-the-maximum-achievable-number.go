package main

func theMaximumAchievableNumber(s string, k int) int {
    for i := 0; i < k; i++ {
        s = strings.Replace(s, "0", "1", 1)
    }
    num, _ := strconv.Atoi(s)
    return num
}