func categorizeBox(length int, width int, height int, mass int) string {
    volume := length * width * height
    bulky := false
    heavy := mass >= 100

    if length >= 1e4 || width >= 1e4 || height >= 1e4 || volume >= 1e9 {
        bulky = true
    }

    if bulky && heavy {
        return "Both"
    } else if bulky {
        return "Bulky"
    } else if heavy {
        return "Heavy"
    } else {
        return "Neither"
    }
}