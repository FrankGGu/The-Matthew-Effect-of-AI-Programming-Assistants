package main

func getBalance(amounts []int) int {
    balance := 0
    for _, a := range amounts {
        balance += a
        if balance < 0 {
            balance = 0
        }
    }
    return balance
}