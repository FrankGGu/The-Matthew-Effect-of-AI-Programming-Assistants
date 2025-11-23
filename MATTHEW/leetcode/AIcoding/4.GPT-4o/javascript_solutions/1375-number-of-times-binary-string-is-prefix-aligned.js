function numTimesAllBlue(light) {
    let maxIndex = 0;
    let count = 0;
    for (let i = 0; i < light.length; i++) {
        maxIndex = Math.max(maxIndex, light[i]);
        if (maxIndex === i + 1) {
            count++;
        }
    }
    return count;
}