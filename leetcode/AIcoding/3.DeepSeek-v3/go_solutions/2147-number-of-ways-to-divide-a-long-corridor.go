func numberOfWays(corridor string) int {
    const mod = 1e9 + 7
    seats := 0
    plants := 0
    res := 1
    for _, c := range corridor {
        if c == 'S' {
            seats++
            if seats > 2 && seats%2 == 1 {
                res = res * (plants + 1) % mod
            }
            plants = 0
        } else {
            if seats >= 2 && seats%2 == 0 {
                plants++
            }
        }
    }
    if seats < 2 || seats%2 != 0 {
        return 0
    }
    return res
}