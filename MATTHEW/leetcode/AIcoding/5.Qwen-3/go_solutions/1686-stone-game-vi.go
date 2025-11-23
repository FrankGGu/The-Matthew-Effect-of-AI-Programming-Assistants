package main

func stoneGameVI(special []int, extra []int) []int {
    n := len(special)
    pairs := make([][2]int, n)
    for i := 0; i < n; i++ {
        pairs[i] = [2]int{special[i], extra[i]}
    }

    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i][0]+pairs[i][1] > pairs[j][0]+pairs[j][1]
    })

    a := 0
    b := 0
    for i := 0; i < n; i++ {
        if i%2 == 0 {
            a += pairs[i][0] + pairs[i][1]
        } else {
            b += pairs[i][0] + pairs[i][1]
        }
    }

    if a > b {
        return []int{0}
    } else if b > a {
        return []int{1}
    } else {
        return []int{0, 1}
    }
}