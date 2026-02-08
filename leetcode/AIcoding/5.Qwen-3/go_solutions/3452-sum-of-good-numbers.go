package main

func sumGoodNumbers() int {
    mod := 1000000007
    result := 0
    for i := 0; i <= 9; i++ {
        for j := 0; j <= 9; j++ {
            for k := 0; k <= 9; k++ {
                if i*i + j*j + k*k == 50 {
                    result = (result + i*100 + j*10 + k) % mod
                }
            }
        }
    }
    return result
}