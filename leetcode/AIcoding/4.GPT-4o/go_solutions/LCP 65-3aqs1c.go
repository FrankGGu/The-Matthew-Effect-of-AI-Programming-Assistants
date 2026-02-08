func acclimateHumidity(hum []int) bool {
    n := len(hum)
    if n < 3 {
        return false
    }
    minHum, maxHum := hum[0], hum[0]
    for _, h := range hum {
        if h < minHum {
            minHum = h
        }
        if h > maxHum {
            maxHum = h
        }
    }
    return maxHum-minHum <= 5
}