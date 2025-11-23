package main

import "fmt"

func countSteppingNumbers(low int, high int) []int {
    var result []int

    var dfs func(num int) 
    dfs = func(num int) {
        if num > high {
            return
        }
        if num >= low {
            result = append(result, num)
        }
        lastDigit := num % 10
        if lastDigit > 0 {
            dfs(num*10 + lastDigit - 1)
        }
        if lastDigit < 9 {
            dfs(num*10 + lastDigit + 1)
        }
    }

    for i := 0; i <= 9; i++ {
        dfs(i)
    }

    return result
}

func main() {
    low, high := 0, 21
    steppingNumbers := countSteppingNumbers(low, high)
    fmt.Println(steppingNumbers)
}