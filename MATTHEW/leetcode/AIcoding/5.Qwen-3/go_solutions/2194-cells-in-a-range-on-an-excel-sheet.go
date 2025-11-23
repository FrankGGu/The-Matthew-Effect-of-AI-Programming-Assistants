package main

func cellsInRange(s string) []string {
    result := []string{}
    startCol := s[0]
    startRow := int(s[1] - '0')
    endCol := s[3]
    endRow := int(s[4] - '0')

    for c := startCol; c <= endCol; c++ {
        for r := startRow; r <= endRow; r++ {
            result = append(result, string(c)+string(r+'0'))
        }
    }

    return result
}