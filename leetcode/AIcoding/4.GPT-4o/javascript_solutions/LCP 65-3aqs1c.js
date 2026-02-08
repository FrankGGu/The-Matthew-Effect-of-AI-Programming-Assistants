function comfortableHumidity(humidity) {
    let sum = 0, count = 0;
    for (let h of humidity) {
        sum += h;
        count++;
    }
    const avg = Math.round(sum / count);
    return humidity.map(h => avg);
}