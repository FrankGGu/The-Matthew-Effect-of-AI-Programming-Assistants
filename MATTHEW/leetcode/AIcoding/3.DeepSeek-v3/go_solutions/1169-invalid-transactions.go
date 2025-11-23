func invalidTransactions(transactions []string) []string {
    type transaction struct {
        name   string
        time   int
        amount int
        city   string
        raw    string
    }

    trans := make([]transaction, len(transactions))
    for i, t := range transactions {
        parts := strings.Split(t, ",")
        time, _ := strconv.Atoi(parts[1])
        amount, _ := strconv.Atoi(parts[2])
        trans[i] = transaction{
            name:   parts[0],
            time:   time,
            amount: amount,
            city:   parts[3],
            raw:    t,
        }
    }

    invalid := make(map[int]bool)
    for i := 0; i < len(trans); i++ {
        if trans[i].amount > 1000 {
            invalid[i] = true
        }
        for j := i + 1; j < len(trans); j++ {
            if trans[i].name == trans[j].name && trans[i].city != trans[j].city && abs(trans[i].time-trans[j].time) <= 60 {
                invalid[i] = true
                invalid[j] = true
            }
        }
    }

    res := make([]string, 0, len(invalid))
    for k := range invalid {
        res = append(res, trans[k].raw)
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}