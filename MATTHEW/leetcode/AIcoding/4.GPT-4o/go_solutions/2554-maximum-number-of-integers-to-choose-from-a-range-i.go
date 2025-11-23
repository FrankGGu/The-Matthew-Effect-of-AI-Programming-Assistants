func maxCount(maxInt int, minInt int, maxChoosableInteger int) int {
    if maxInt < minInt {
        return 0
    }
    count := 0
    for i := minInt; i <= maxInt && i <= maxChoosableInteger; i++ {
        count++
    }
    return count
}