var categorizeBox = function(length, width, height, mass) {
    const volume = length * width * height;
    let isBulky = false;
    let isHeavy = false;

    if (length >= 1e4 || width >= 1e4 || height >= 1e4 || volume >= 1e9) {
        isBulky = true;
    }

    if (mass >= 100) {
        isHeavy = true;
    }

    if (isBulky && isHeavy) {
        return "Both";
    } else if (isBulky) {
        return "Bulky";
    } else if (isHeavy) {
        return "Heavy";
    } else {
        return "Neither";
    }
};