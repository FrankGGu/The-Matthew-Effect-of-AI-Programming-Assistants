var convertTemperature = function(value, unit, toUnit) {
    if (unit === "C" && toUnit === "F") {
        return value * 1.80 + 32.00;
    } else if (unit === "F" && toUnit === "C") {
        return (value - 32.00) / 1.80;
    } else if (unit === "C" && toUnit === "K") {
        return value + 273.15;
    } else if (unit === "K" && toUnit === "C") {
        return value - 273.15;
    } else if (unit === "F" && toUnit === "K") {
        return (value - 32.00) / 1.80 + 273.15;
    } else if (unit === "K" && toUnit === "F") {
        return (value - 273.15) * 1.80 + 32.00;
    } else {
        return value;
    }
};