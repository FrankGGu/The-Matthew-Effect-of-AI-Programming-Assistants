package main

func kthCharacter(n int, k int) byte {
    k--
    for n > 1 {
        n--
        k = (k + 1) % (1 << n)
    }
    return 'a' + byte(k)
}