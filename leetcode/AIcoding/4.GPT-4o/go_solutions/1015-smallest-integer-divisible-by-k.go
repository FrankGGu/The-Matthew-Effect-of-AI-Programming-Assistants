func smallestRepunitDivByK(K int) int {
    if K % 2 == 0 || K % 5 == 0 {
        return -1
    }
    n := 1
    num := 1 % K
    for num != 0 {
        num = (num * 10 + 1) % K
        n++
    }
    return n
}