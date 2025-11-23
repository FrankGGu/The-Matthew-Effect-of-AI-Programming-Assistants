package main

func maxOperations(s string) int {
    ones := 0
    operations := 0
    for _, c := range s {
        if c == '1' {
            ones++
        } else {
            if ones > 0 {
                operations++
            }
        }
    }
    return operations
}