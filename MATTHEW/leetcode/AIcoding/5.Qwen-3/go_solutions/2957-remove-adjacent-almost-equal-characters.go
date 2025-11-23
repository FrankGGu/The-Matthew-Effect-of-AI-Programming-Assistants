package main

func removeAlmostEqualCharacters(s string) int {
    n := len(s)
    i := 0
    result := 0
    for i < n {
        j := i + 1
        for j < n && abs(int(s[j])-int(s[j-1])) <= 1 {
            j++
        }
        result += (j - i + 1) / 2
        i = j
    }
    return result
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}