package main

func applyDiscount(orders []string, n int, discount int) []string {
    res := make([]string, 0)
    count := 0
    for _, order := range orders {
        count++
        if count%n == 0 {
            price, _ := strconv.Atoi(order[len(order)-3:])
            discounted := price * (100 - discount) / 100
            res = append(res, order[:len(order)-3] + fmt.Sprintf("%d", discounted))
        } else {
            res = append(res, order)
        }
    }
    return res
}