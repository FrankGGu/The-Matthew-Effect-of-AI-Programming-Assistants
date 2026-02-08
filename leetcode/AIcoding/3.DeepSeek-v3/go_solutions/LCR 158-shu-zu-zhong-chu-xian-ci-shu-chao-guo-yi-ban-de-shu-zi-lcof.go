func inventoryManagement(stock []int) int {
    candidate := 0
    count := 0

    for _, num := range stock {
        if count == 0 {
            candidate = num
            count = 1
        } else if num == candidate {
            count++
        } else {
            count--
        }
    }

    return candidate
}