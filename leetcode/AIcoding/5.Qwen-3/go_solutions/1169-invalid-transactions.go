package main

func invalidTransactions(b []string) []string {
    type Transaction struct {
        name, time, amount, city string
    }
    var transactions []Transaction
    for _, s := range b {
        parts := strings.Split(s, ",")
        transactions = append(transactions, Transaction{parts[0], parts[1], parts[2], parts[3]})
    }

    res := make([]string, 0)
    for i, t := range transactions {
        if !isValid(t, transactions) {
            res = append(res, b[i])
        }
    }
    return res
}

func isValid(t Transaction, transactions []Transaction) bool {
    if atoi(t.amount) > 1000 {
        return false
    }
    for j, other := range transactions {
        if t.name == other.name && t.time != other.time {
            if abs(atoi(t.time)-atoi(other.time)) <= 60 {
                if t.city != other.city {
                    return false
                }
            }
        }
    }
    return true
}

func atoi(s string) int {
    var n int
    for _, c := range s {
        n = n*10 + int(c-'0')
    }
    return n
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}