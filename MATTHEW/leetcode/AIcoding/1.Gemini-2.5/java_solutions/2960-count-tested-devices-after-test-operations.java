class Solution {
    public int countTestedDevices(int[] batteryPercentages) {
        int testedDevicesCount = 0;
        for (int i = 0; i < batteryPercentages.length; i++) {
            if (batteryPercentages[i] - testedDevicesCount > 0) {
                testedDevicesCount++;
            }
        }
        return testedDevicesCount;
    }
}