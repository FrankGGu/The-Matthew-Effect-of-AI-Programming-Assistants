func distMoney(m int, c int) int {
    if c > m {
        return -1
    }
    if c == m {
        return 0
    }
    if c == m+1 {
        return -1
    }

    maxChildren := 0
    remainingMoney := m

    for i := 0; i < c; i++ {
        if remainingMoney > 0 {
            remainingMoney--
            if remainingMoney > 0 && c-i-1 > 0 {
                maxChildren++
                remainingMoney -= 7
            } else {
                maxChildren++
                break
            }
        }
        if remainingMoney < 0 {
            break
        }
    }

    if remainingMoney < 0 {
        return maxChildren - 1
    }
    return maxChildren
}