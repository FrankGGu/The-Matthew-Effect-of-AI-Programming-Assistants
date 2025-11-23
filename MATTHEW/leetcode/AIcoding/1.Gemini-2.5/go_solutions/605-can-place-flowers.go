func canPlaceFlowers(flowerbed []int, n int) bool {
    if n == 0 {
        return true
    }

    length := len(flowerbed)

    for i := 0; i < length; i++ {
        if flowerbed[i] == 0 {
            leftEmpty := (i == 0) || (flowerbed[i-1] == 0)
            rightEmpty := (i == length-1) || (flowerbed[i+1] == 0)

            if leftEmpty && rightEmpty {
                flowerbed[i] = 1
                n--
                if n == 0 {
                    return true
                }
            }
        }
    }

    return n <= 0
}