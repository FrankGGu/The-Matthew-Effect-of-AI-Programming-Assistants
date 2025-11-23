func numWays(s string) int {
    mod := 1000000007
    count := 0
    for _, char := range s {
        if char == '1' {
            count++
        }
    }

    if count == 0 {
        return (1 * (len(s)-1) * (len(s)-2) / 2) % mod
    }

    if count % 3 != 0 {
        return 0
    }

    part := count / 3
    first, second, temp := 0, 0, 0

    for i, char := range s {
        if char == '1' {
            temp++
            if temp == 1 {
                first = i
            } else if temp == part + 1 {
                second = i
                break
            }
        }
    }

    countFirst := 0
    for i := first; i < len(s); i++ {
        if s[i] == '1' {
            countFirst++
        }
        if countFirst == part {
            countFirst++
        }
        if countFirst == part + 1 {
            break
        }
    }

    countSecond := 0
    for i := second; i < len(s); i++ {
        if s[i] == '1' {
            countSecond++
        }
        if countSecond == part {
            countSecond++
        }
            if countSecond == part + 1 {
            break
        }
    }

    return (countFirst * countSecond) % mod
}