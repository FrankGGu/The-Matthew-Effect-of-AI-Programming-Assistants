func customSortString(order string, str string) string {
    count := make([]int, 26)
    for _, c := range str {
        count[c-'a']++
    }

    result := []byte{}
    for _, c := range order {
        if count[c-'a'] > 0 {
            result = append(result, bytes.Repeat([]byte{byte(c)}, count[c-'a'])...)
            count[c-'a'] = 0
        }
    }

    for i := 0; i < 26; i++ {
        if count[i] > 0 {
            result = append(result, bytes.Repeat([]byte{byte(i + 'a')}, count[i])...)
        }
    }

    return string(result)
}