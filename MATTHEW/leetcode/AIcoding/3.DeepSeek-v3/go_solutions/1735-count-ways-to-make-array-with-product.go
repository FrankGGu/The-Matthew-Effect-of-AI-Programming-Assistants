const mod = 1e9 + 7
const maxK = 1e4 + 10
const maxN = 1e4 + 13

var (
    spf    [maxN]int
    comb   [maxN][15]int
    inited bool
)

func init() {
    if inited {
        return
    }
    inited = true
    sieve()
    precomputeComb()
}

func sieve() {
    for i := 2; i < maxN; i++ {
        if spf[i] == 0 {
            spf[i] = i
            if i*i < maxN {
                for j := i * i; j < maxN; j += i {
                    if spf[j] == 0 {
                        spf[j] = i
                    }
                }
            }
        }
    }
}

func precomputeComb() {
    comb[0][0] = 1
    for n := 1; n < maxN; n++ {
        comb[n][0] = 1
        for k := 1; k < 15; k++ {
            comb[n][k] = (comb[n-1][k-1] + comb[n-1][k]) % mod
        }
    }
}

func getPrimeFactors(x int) map[int]int {
    factors := make(map[int]int)
    for x > 1 {
        p := spf[x]
        for x%p == 0 {
            factors[p]++
            x /= p
        }
    }
    return factors
}

func waysToFillArray(queries [][]int) []int {
    res := make([]int, len(queries))
    for i, q := range queries {
        n, k := q[0], q[1]
        if k == 1 {
            res[i] = 1
            continue
        }
        factors := getPrimeFactors(k)
        ans := 1
        for _, cnt := range factors {
            ans = (ans * comb[n+cnt-1][cnt]) % mod
        }
        res[i] = ans
    }
    return res
}