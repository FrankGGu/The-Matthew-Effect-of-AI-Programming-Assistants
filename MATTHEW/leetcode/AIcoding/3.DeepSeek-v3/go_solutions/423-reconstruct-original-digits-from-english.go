func originalDigits(s string) string {
    count := make([]int, 10)
    for i := 0; i < len(s); i++ {
        c := s[i]
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
        case 'h':
            count[3]++
        case 'f':
            count[5]++
        case 's':
            count[7]++
        case 'o':
            count[1]++
        case 'i':
            count[9]++
        }
    }
    count[3] -= count[8]
    count[5] -= count[4]
    count[7] -= count[6]
    count[1] -= count[0] + count[2] + count[4]
    count[9] -= count[5] + count[6] + count[8]

    var res []byte
    for i := 0; i <= 9; i++ {
        for j := 0; j < count[i]; j++ {
            res = append(res, byte(i)+'0')
        }
    }
    return string(res)
}