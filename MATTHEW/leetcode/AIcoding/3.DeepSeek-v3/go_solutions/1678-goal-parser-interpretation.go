func interpret(command string) string {
    var res strings.Builder
    for i := 0; i < len(command); {
        if command[i] == 'G' {
            res.WriteByte('G')
            i++
        } else if command[i] == '(' && command[i+1] == ')' {
            res.WriteByte('o')
            i += 2
        } else {
            res.WriteString("al")
            i += 4
        }
    }
    return res.String()
}