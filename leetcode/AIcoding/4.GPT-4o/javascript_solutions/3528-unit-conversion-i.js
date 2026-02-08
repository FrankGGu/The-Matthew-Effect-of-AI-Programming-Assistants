function convertUnit(value, fromUnit, toUnit) {
    const conversionRates = {
        "inch": 1, 
        "foot": 12, 
        "yard": 36, 
        "mile": 63360, 
        "millimeter": 0.0393701, 
        "centimeter": 0.393701, 
        "meter": 39.3701, 
        "kilometer": 39370.1
    };

    return value * (conversionRates[fromUnit] / conversionRates[toUnit]);
}