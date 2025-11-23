func kItemsWithMaximumSum(numOnes int, numZeros int, numNegOnes int, k int) int {
    res := 0
    if k <= numOnes {
        return k
    }
    res += numOnes
    k -= numOnes
    if k <= numZeros {
        return res
    }
    k -= numZeros
    res -= k
    return res
}