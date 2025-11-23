func categorizeBox(length int, width int, height int, mass int) string {
    volume := length * width * height
    isBulky := length >= 10000 || width >= 10000 || height >= 10000 || volume >= 1000000000
    isHeavy := mass >= 100

    if isBulky {
        if isHeavy {
            return "Both"
        }
        return "Bulky"
    }
    if isHeavy {
        return "Heavy"
    }
    return "Neither"
}