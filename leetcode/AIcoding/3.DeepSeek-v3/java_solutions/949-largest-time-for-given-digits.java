class Solution {
    public String largestTimeFromDigits(int[] arr) {
        String res = "";
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                for (int k = 0; k < 4; k++) {
                    if (i == j || i == k || j == k) continue;
                    int l = 6 - i - j - k;
                    String hour = "" + arr[i] + arr[j];
                    String minute = "" + arr[k] + arr[l];
                    String time = hour + ":" + minute;
                    if (hour.compareTo("24") < 0 && minute.compareTo("60") < 0 && time.compareTo(res) > 0) {
                        res = time;
                    }
                }
            }
        }
        return res;
    }
}