class Solution {
    public int minimumTime(String cars) {
        int n = cars.length();
        int time = 0;
        for (int i = 0; i < n; i++) {
            if (cars.charAt(i) == '1') {
                time += (i + 1) * 2;
            } else {
                time += (i + 1);
            }
        }
        return time;
    }
}