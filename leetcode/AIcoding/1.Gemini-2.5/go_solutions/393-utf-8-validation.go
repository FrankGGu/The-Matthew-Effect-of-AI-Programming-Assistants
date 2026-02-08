func isValidUtf8(data []int) bool {
    numBytesToFollow := 0

    for _, b := range data {
        if numBytesToFollow == 0 {
            // Determine the type of UTF-8 character
            if (b >> 7) == 0b0 {
                // 1-byte