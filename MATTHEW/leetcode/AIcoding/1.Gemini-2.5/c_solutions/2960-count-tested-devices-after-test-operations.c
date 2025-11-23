int countTestedDevices(int* batteryPercentages, int batteryPercentagesSize) {
    int testedDevices = 0;
    for (int i = 0; i < batteryPercentagesSize; i++) {
        if (batteryPercentages[i] > testedDevices) {
            testedDevices++;
        }
    }
    return testedDevices;
}