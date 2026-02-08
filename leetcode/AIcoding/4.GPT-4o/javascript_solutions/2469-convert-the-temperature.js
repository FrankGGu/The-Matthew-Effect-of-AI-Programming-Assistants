var convertTemperature = function(celsius) {
    return [(celsius + 273.15).toFixed(5), (celsius * 1.80 + 32.00).toFixed(5)];
};