function categorizeBox(length, width, height, mass) {
    const isHeavy = mass >= 100;
    const isBulky = (length >= 1000 || width >= 1000 || height >= 1000) || (length * width * height >= 1e9);

    if (isBulky && isHeavy) {
        return "Both";
    } else if (isBulky) {
        return "Bulky";
    } else if (isHeavy) {
        return "Heavy";
    } else {
        return "Neither";
    }
}