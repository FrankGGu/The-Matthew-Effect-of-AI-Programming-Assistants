package main

func numberOf laserBeams(bank []string) int {
    var prev int
    var result int
    for _, row := range bank {
        count := 0
        for _, ch := range row {
            if ch == '1' {
                count++
            }
        }
        if count > 0 {
            if prev > 0 {
                result += prev * count
            }
            prev = count
        }
    }
    return result
}