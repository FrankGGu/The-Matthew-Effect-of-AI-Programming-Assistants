int countTestedDevices(int* batteryPercentages, int batteryPercentagesSize) {
    int tested = 0;
    for (int i = 0; i < batteryPercentagesSize; i++) {
        if (batteryPercentages[i] > tested) {
            tested++;
        }
    }
    return tested;
}