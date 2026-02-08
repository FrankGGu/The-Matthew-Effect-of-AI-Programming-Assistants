package main

func interpret(command string) string {
    var result []rune
    for i := 0; i < len(command); i++ {
        if command[i] == 'G' {
            result = append(result, 'G')
        } else if command[i] == '(' && command[i+1] == ')' {
            result = append(result, 'o')
            i++
        } else if command[i] == '(' && command[i+1] == 'a' && command[i+2] == 'l' && command[i+3] == ')' {
            result = append(result, 'a', 'l')
            i += 3
        }
    }
    return string(result)
}