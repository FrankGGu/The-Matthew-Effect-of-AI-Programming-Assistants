package main

func categorizeBox(length int, width int, height int, mass int) string {
    var isHeavy bool
    var isBulky bool

    if mass >= 100 {
        isHeavy = true
    }

    if length >= 100000 || width >= 100000 || height >= 100000 {
        isBulky = true
    } else {
        volume := length * width * height
        if volume >= 1e9 {
            isBulky = true
        }
    }

    if isBulky && isHeavy {
        return "Both"
    } else if isBulky {
        return "Bulky"
    } else if isHeavy {
        return "Heavy"
    } else {
        return "Neither"
    }
}