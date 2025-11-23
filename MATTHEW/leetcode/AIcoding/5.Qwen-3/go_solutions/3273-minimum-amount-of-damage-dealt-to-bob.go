package main

func minDamageSum(power int, damage []int, bossPower int, bossDamage int) int {
    n := len(damage)
    type pair struct {
        p, d int
    }
    pairs := make([]pair, n)
    for i := 0; i < n; i++ {
        pairs[i] = pair{power, damage[i]}
    }
    sort.Slice(pairs, func(i, j int) bool {
        if pairs[i].p != pairs[j].p {
            return pairs[i].p < pairs[j].p
        }
        return pairs[i].d > pairs[j].d
    })
    totalDamage := 0
    for _, p := range pairs {
        totalDamage += p.d
    }
    return totalDamage
}