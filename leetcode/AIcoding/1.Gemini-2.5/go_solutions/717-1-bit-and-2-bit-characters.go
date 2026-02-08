func isOneBitCharacter(bits []int) bool {
    n := len(bits)
    i := 0
    for i < n-1 { // Iterate until one character before the end
        if bits[i] == 0 {
            i++ // 1-bit character, advance by 1
        } else {