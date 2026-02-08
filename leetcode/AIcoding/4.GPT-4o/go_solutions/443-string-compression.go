func compress(chars []byte) int {
    n := len(chars)
    writeIndex := 0
    readIndex := 0

    for readIndex < n {
        char := chars[readIndex]
        count := 0

        for readIndex < n && chars[readIndex] == char {
            readIndex++
            count++
        }

        chars[writeIndex] = char
        writeIndex++

        if count > 1 {
            for _, c := range strconv.Itoa(count) {
                chars[writeIndex] = byte(c)
                writeIndex++
            }
        }
    }

    return writeIndex
}