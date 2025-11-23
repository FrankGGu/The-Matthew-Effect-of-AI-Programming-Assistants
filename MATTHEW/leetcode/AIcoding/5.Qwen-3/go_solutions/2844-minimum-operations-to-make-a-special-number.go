package main

func minimumOperationsToMakeASpecialNumber(s string, a int, b int) int {
    n := len(s)
    minOps := 1000000

    for i := 0; i < n; i++ {
        if s[i] == '0' {
            continue
        }
        for j := i; j < n; j++ {
            numStr := s[i : j+1]
            num, _ := strconv.Atoi(numStr)
            if num%a == 0 && num%b == 0 {
                ops := (i) + (n - j - 1)
                if ops < minOps {
                    minOps = ops
                }
            }
        }
    }

    if minOps == 1000000 {
        return -1
    }
    return minOps
}