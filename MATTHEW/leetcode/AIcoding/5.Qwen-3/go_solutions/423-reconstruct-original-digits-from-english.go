package main

func originalDigits(s string) string {
    count := make([]int, 10)
    for _, c := range s {
        switch c {
        case 'z':
            count[0]++
        case 'w':
            count[2]++
        case 'u':
            count[4]++
        case 'x':
            count[6]++
        case 'g':
            count[8]++
        case 'o':
            count[1]++
        case 't':
            count[3]++
        case 'f':
            count[5]++
        case 's':
            count[7]++
        case 'i':
            count[9]++
        }
    }

    count[1] -= count[0] + count[2] + count[4]
    count[3] -= count[2]
    count[5] -= count[4]
    count[7] -= count[6]
    count[9] -= count[8] + count[5] + count[3]

    res := ""
    for i := 0; i <= 9; i++ {
        res += strings.Repeat(strconv.Itoa(i), count[i])
    }
    return res
}