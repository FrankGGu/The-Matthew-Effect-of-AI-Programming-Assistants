func minimumOperations(num string) int {
    count := 0
    hasEven := false
    hasOdd := false
    for _, ch := range num {
        if (ch-'0')%2 == 0 {
            hasEven = true
        } else {
            hasOdd = true
        }
    }

    if hasEven && hasOdd {
        return 1
    }
    if hasEven || hasOdd {
        return 0
    }
    return -1
}