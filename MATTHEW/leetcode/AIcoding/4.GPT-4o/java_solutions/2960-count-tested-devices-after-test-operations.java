class Solution {
    public int countDevices(int[] devices) {
        int count = 0;
        for (int device : devices) {
            if (device == 1) {
                count++;
            }
        }
        return count;
    }
}