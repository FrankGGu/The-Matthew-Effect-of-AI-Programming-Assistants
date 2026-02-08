func toHex(num int) string {
    if num == 0 {
        return "0"
    }
    hexChars := []byte{'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'}
    res := make([]byte, 0)
    for i := 0; i < 8 && num != 0; i++ {
        digit := num & 0xf
        res = append([]byte{hexChars[digit]}, res...)
        num >>= 4
    }
    return string(res)
}