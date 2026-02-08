def categorizeBox(length: int, width: int, height: int, mass: int) -> str:
    volume = length * width * height
    isBulky = length >= 10000 or width >= 10000 or height >= 10000 or volume >= 1000000000
    isHeavy = mass >= 100

    if isBulky and isHeavy:
        return "Both"
    elif isBulky:
        return "Bulky"
    elif isHeavy:
        return "Heavy"
    else:
        return "Neither"