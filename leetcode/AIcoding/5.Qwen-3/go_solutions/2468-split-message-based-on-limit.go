package main

func splitMessage(message string, limit int) [][]byte {
    n := len(message)
    res := [][]byte{}
    idx := 0
    for idx < n {
        length := len(strconv.Itoa(idx+1))
        if length+limit > len(message)-idx+length {
            return nil
        }
        part := make([]byte, limit)
        copy(part, message[idx:idx+limit-length])
        res = append(res, part)
        idx += limit - length
    }
    return res
}