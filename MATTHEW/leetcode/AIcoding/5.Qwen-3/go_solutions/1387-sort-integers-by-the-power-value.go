package main

func numberOfSteps(num int) int {
    steps := 0
    for num > 0 {
        if num%2 == 0 {
            num /= 2
        } else {
            num--
        }
        steps++
    }
    return steps
}

type Pair struct {
    num int
    power int
}

func getPower(num int) int {
    steps := 0
    for num > 0 {
        if num%2 == 0 {
            num /= 2
        } else {
            num--
        }
        steps++
    }
    return steps
}

func sortJumbled(arr []int) []int {
    pairs := make([]Pair, len(arr))
    for i, num := range arr {
        pairs[i] = Pair{num, getPower(num)}
    }

    sort.Slice(pairs, func(i, j int) bool {
        if pairs[i].power != pairs[j].power {
            return pairs[i].power < pairs[j].power
        }
        return pairs[i].num < pairs[j].num
    })

    result := make([]int, len(arr))
    for i, p := range pairs {
        result[i] = p.num
    }
    return result
}