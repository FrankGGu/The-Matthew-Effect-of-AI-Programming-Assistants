import "strings"

func interpret(command string) string {
    var result strings.Builder
    n := len(command)
    for i := 0; i < n; {
        if command[i] == 'G' {
            result.WriteByte('G')
            i++
        } else if command[i] == '(' {
            if command[i+1] == ')' { // This is "()"
                result.WriteByte('o')
                i += 2
            } else { // This is "(al)"
                result.WriteString("al")
                i += 4
            }
        }
    }
    return result.String()
}