package main

func listGame(n int, leftToRight bool) int {
    if n == 1 {
        return 1
    }
    if leftToRight {
        return 2 * listGame(n/2, false)
    } else {
        return 2 * listGame(n/2, true) - 1
    }
}

func eliminateOperators(n int) int {
    return listGame(n, true)
}