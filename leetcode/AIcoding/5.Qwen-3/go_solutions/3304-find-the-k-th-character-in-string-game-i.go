package main

func kthCharacter(s string, k int) byte {
    for len(s) < k {
        s += s
    }
    return s[k-1]
}