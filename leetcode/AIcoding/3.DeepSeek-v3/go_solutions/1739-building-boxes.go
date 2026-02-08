func minimumBoxes(n int) int {
    level := 1
    total := 0
    next := 0

    for total < n {
        next += level
        total += next
        if total >= n {
            break
        }
        level++
    }

    if total == n {
        return next
    }

    total -= next
    next -= level
    k := 1

    for total < n {
        total += k
        next++
        k++
    }

    return next
}