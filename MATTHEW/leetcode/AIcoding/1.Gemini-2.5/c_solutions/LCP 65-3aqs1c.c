int countComfortableHumidities(int* humidities, int humiditiesSize, int lower, int upper) {
    int comfortableCount = 0;
    for (int i = 0; i < humiditiesSize; i++) {
        if (humidities[i] >= lower && humidities[i] <= upper) {
            comfortableCount++;
        }
    }
    return comfortableCount;
}