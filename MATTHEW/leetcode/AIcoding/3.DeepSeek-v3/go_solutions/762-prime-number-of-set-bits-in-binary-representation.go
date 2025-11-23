func countPrimeSetBits(left int, right int) int {
    primes := map[int]bool{
        2:  true,
        3:  true,
        5:  true,
        7:  true,
        11: true,
        13: true,
        17: true,
        19: true,
        23: true,
        29: true,
        31: true,
    }
    count := 0
    for num := left; num <= right; num++ {
        bits := bits.OnesCount(uint(num))
        if primes[bits] {
            count++
        }
    }
    return count
}