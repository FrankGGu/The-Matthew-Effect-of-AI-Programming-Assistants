func distMoney(money int, children int) int {
    if money < children {
        return -1
    }
    money -= children
    max := money / 7
    remaining := money % 7
    if max > children {
        return children - 1
    }
    if max == children {
        if remaining == 0 {
            return children
        }
        return children - 1
    }
    if remaining == 3 && max == children - 1 {
        return max - 1
    }
    return max
}