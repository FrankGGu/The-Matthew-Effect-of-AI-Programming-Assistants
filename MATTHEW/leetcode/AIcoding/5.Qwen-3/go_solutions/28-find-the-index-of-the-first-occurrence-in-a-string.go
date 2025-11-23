package main

func strStr(haystack string, needle string) int {
    lenH := len(haystack)
    lenN := len(needle)
    if lenN == 0 {
        return 0
    }
    if lenH < lenN {
        return -1
    }
    for i := 0; i <= lenH-lenN; i++ {
        j := 0
        for j < lenN && haystack[i+j] == needle[j] {
            j++
        }
        if j == lenN {
            return i
        }
    }
    return -1
}