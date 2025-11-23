func canPlaceFlowers(flowerbed []int, n int) bool {
    count := 0
    length := len(flowerbed)
    for i := 0; i < length; i++ {
        if flowerbed[i] == 0 {
            prev := 0
            if i > 0 {
                prev = flowerbed[i-1]
            }
            next := 0
            if i < length-1 {
                next = flowerbed[i+1]
            }
            if prev == 0 && next == 0 {
                flowerbed[i] = 1
                count++
            }
        }
    }
    return count >= n
}