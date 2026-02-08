package main

func maxProduct(s string) int {
    n := len(s)
    palindromes := make([][]int, n)
    for i := 0; i < n; i++ {
        palindromes[i] = make([]int, n)
    }

    for i := 0; i < n; i++ {
        l, r := i, i
        for l >= 0 && r < n && s[l] == s[r] {
            palindromes[l][r] = 1
            l--
            r++
        }
        l, r = i, i+1
        for l >= 0 && r < n && s[l] == s[r] {
            palindromes[l][r] = 1
            l--
            r++
        }
    }

    maxProd := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if palindromes[i][j] == 1 {
                for k := 0; k < i; k++ {
                    for l := k; l < i; l++ {
                        if palindromes[k][l] == 1 {
                            prod := (j - i + 1) * (l - k + 1)
                            if prod > maxProd {
                                maxProd = prod
                            }
                        }
                    }
                }
                for k := j + 1; k < n; k++ {
                    for l := k; l < n; l++ {
                        if palindromes[k][l] == 1 {
                            prod := (j - i + 1) * (l - k + 1)
                            if prod > maxProd {
                                maxProd = prod
                            }
                        }
                    }
                }
            }
        }
    }

    return maxProd
}