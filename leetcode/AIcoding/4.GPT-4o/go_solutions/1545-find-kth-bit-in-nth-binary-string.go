func findKthBit(n int, k int) byte {
    if k == 1 {
        return '0'
    }
    length := 1 << n - 1
    if k == length/2 {
        return '1'
    }
    if k > length/2 {
        return flipBit(findKthBit(n, length-k+1))
    }
    return findKthBit(n-1, k)
}

func flipBit(b byte) byte {
    if b == '0' {
        return '1'
    }
    return '0'
}