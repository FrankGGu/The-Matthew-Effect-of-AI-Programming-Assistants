func maxRevenue(seats int, reservedSeats [][]int) int {
    reserved := make(map[int]map[int]bool)
    for _, seat := range reservedSeats {
        row, col := seat[0], seat[1]
        if reserved[row] == nil {
            reserved[row] = make(map[int]bool)
        }
        reserved[row][col] = true
    }

    totalRevenue := 0
    for row := 1; row <= seats; row++ {
        if reserved[row] == nil {
            totalRevenue += 8
            continue
        }

        count := 0
        for col := 1; col <= 10; col++ {
            if reserved[row][col] {
                count++
            }
        }

        if count == 0 {
            totalRevenue += 8
        } else if count == 1 {
            totalRevenue += 7
        } else if count == 2 {
            totalRevenue += 6
        } else if count == 3 {
            totalRevenue += 5
        } else if count == 4 {
            totalRevenue += 4
        } else if count == 5 {
            totalRevenue += 6
        } else if count == 6 {
            totalRevenue += 7
        } else if count == 7 {
            totalRevenue += 8
        }
    }

    return totalRevenue
}