package main

func numberOfWeakCharacters(accounts [][]int) int {
    sort.Slice(accounts, func(i, j int) bool {
        if accounts[i][0] == accounts[j][0] {
            return accounts[i][1] > accounts[j][1]
        }
        return accounts[i][0] < accounts[j][0]
    })
    count := 0
    maxDef := 0
    for _, acc := range accounts {
        if acc[1] < maxDef {
            count++
        } else {
            maxDef = acc[1]
        }
    }
    return count
}