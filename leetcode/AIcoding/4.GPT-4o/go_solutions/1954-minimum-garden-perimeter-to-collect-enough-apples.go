func minimumPerimeter(n int64) int64 {
    side := int64(1)
    for side*(side+1)*(side+2)/6 < n {
        side++
    }
    return 8 * side
}