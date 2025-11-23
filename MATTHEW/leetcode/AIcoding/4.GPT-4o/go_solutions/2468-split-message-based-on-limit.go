func splitMessage(message string, limit int) []string {
    n := len(message)
    var result []string
    totalLen := 0
    msgCount := 1

    for {
        suffix := fmt.Sprintf("<%d/%d>", msgCount, 1)
        maxMsgLen := limit - len(suffix)

        if totalLen+maxMsgLen >= n {
            result = append(result, message[totalLen:])
            break
        }

        result = append(result, message[totalLen:totalLen+maxMsgLen])
        totalLen += maxMsgLen
        msgCount++
    }

    return result
}