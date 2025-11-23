package main

func findKthBit(n int, k int) byte {
    if n == 1 {
        return '1'
    }
    length := 1 << uint(n-1)
    if k == length {
        return '1'
    } else if k < length {
        return findKthBit(n-1, k)
    } else {
        return '0' + '1' - findKthBit(n-1, length-k)
    }
}