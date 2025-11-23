package main

func numberofBacklogCards(orders [][]int) int {
    buy := make([][]int, 0)
    sell := make([][]int, 0)

    for _, order := range orders {
        price, amount, type_ := order[0], order[1], order[2]
        if type_ == 0 {
            // Buy order
            for amount > 0 && len(sell) > 0 && sell[0][0] <= price {
                if sell[0][1] > amount {
                    sell[0][1] -= amount
                    amount = 0
                } else {
                    amount -= sell[0][1]
                    sell = sell[1:]
                }
            }
            if amount > 0 {
                insert(&buy, price, amount)
            }
        } else {
            // Sell order
            for amount > 0 && len(buy) > 0 && buy[0][0] >= price {
                if buy[0][1] > amount {
                    buy[0][1] -= amount
                    amount = 0
                } else {
                    amount -= buy[0][1]
                    buy = buy[1:]
                }
            }
            if amount > 0 {
                insert(&sell, price, amount)
            }
        }
    }

    total := 0
    for _, b := range buy {
        total += b[1]
    }
    for _, s := range sell {
        total += s[1]
    }
    return total % (1000000007)
}

func insert(list *[][]int, price, amount int) {
    i := 0
    for i < len(*list) && (*list)[i][0] > price {
        i++
    }
    if i < len(*list) && (*list)[i][0] == price {
        (*list)[i][1] += amount
    } else {
        *list = append(*list, []int{price, amount})
        for i > 0 && (*list)[i-1][0] > (*list)[i][0] {
            (*list)[i], (*list)[i-1] = (*list)[i-1], (*list)[i]
            i--
        }
    }
}