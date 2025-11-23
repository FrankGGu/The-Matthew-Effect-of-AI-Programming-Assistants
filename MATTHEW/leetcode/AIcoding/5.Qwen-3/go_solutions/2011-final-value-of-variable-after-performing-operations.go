package main

func finalValueAfterOperations(operations []string) int {
    x := 0
    for _, op := range operations {
        if op == "++X" || op == "X++" {
            x++
        } else if op == "--X" || op == "X--" {
            x--
        }
    }
    return x
}