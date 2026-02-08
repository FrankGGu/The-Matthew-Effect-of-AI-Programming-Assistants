var categorizeBox = function(length, width, height, mass) {
    const isBulky = (length >= 10000 || width >= 10000 || height >= 10000 || (BigInt(length) * BigInt(width) * BigInt(height)) >= 1000000000);
    const isHeavy = (mass >= 100);

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