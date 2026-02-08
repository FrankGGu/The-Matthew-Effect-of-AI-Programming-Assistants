package main

func commonChars(A []string) []string {
    if len(A) == 0 {
        return []string{}
    }

    count := make([]int, 26)
    for _, c := range A[0] {
        count[c-'a']++
    }

    for i := 1; i < len(A); i++ {
        temp := make([]int, 26)
        for _, c := range A[i] {
            temp[c-'a']++
        }
        for j := 0; j < 26; j++ {
            count[j] = min(count[j], temp[j])
        }
    }

    result := []string{}
    for i := 0; i < 26; i++ {
        for count[i] > 0 {
            result = append(result, string('a'+i))
            count[i]--
        }
    }

    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}