package main

func modifyColumns(employees []string) []string {
    for i := 0; i < len(employees); i++ {
        parts := split(employees[i], " ")
        if len(parts) == 2 {
            employees[i] = parts[1] + " " + parts[0]
        }
    }
    return employees
}

func split(s, sep string) []string {
    var result []string
    var start int
    for i := 0; i < len(s); i++ {
        if s[i] == sep[0] {
            if i+1 <= len(s) && s[i:i+len(sep)] == sep {
                result = append(result, s[start:i])
                start = i + len(sep)
                i += len(sep) - 1
            }
        }
    }
    result = append(result, s[start:])
    return result
}