func clumsy(N int) int {
    if N == 0 {
        return 0
    }
    if N == 1 {
        return 1
    }

    result := 0
    sign := 1

    for i := N; i > 0; i-- {
        if i == N {
            result += i
        } else if (N-i)%4 == 1 {
            result -= i
        } else if (N-i)%4 == 2 {
            result += i * (i - 1)
            i--
        } else if (N-i)%4 == 3 {
            result += i / (i - 1)
            i--
        }
        sign = -sign
    }

    return result
}