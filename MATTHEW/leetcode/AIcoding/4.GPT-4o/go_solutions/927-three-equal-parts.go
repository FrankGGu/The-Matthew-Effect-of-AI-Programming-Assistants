func threeEqualParts(A []int) []int {
    n := len(A)
    countOne := 0
    for _, v := range A {
        if v == 1 {
            countOne++
        }
    }
    if countOne%3 != 0 {
        return []int{-1, -1}
    }
    if countOne == 0 {
        return []int{0, n - 1}
    }

    partSize := countOne / 3
    first, second, third := -1, -1, -1
    currOneCount := 0

    for i, v := range A {
        if v == 1 {
            currOneCount++
            if currOneCount == 1 {
                first = i
            } else if currOneCount == partSize+1 {
                second = i
            } else if currOneCount == 2*partSize+1 {
                third = i
            }
        }
    }

    for third < n && A[first] == A[second] && A[second] == A[third] {
        first++
        second++
        third++
    }

    if third < n {
        return []int{-1, -1}
    }
    return []int{first - 1, second}
}