package main

func concatenatedBinary(n int) int {
    const mod = 1e9 + 7
    var result uint64 = 0
    for i := 1; i <= n; i++ {
        result = (result << uint64(len(bin(i)))) % mod
        result = (result + uint64(i)) % mod
    }
    return int(result)
}

func bin(n int) string {
    if n == 0 {
        return "0"
    }
    var res string
    for n > 0 {
        if n%2 == 1 {
            res = "1" + res
        } else {
            res = "0" + res
        }
        n /= 2
    }
    return res
}