func passThePillow(n int, time int) int {
    rounds := time / (n - 1)
    remainder := time % (n - 1)
    if rounds%2 == 0 {
        return 1 + remainder
    } else {
        return n - remainder
    }
}