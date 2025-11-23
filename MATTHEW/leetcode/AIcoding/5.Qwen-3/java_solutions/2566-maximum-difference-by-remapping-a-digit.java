public class Solution {
    public int maxDiff(int num) {
        String s = String.valueOf(num);
        char[] arr = s.toCharArray();
        int min = num;
        int max = num;
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] != '9') {
                char c = arr[i];
                char[] temp = arr.clone();
                for (int j = 0; j < temp.length; j++) {
                    if (temp[j] == c) {
                        temp[j] = '9';
                    }
                }
                max = Math.max(max, Integer.parseInt(new String(temp)));
                break;
            }
        }
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] != '1') {
                char c = arr[i];
                char[] temp = arr.clone();
                for (int j = 0; j < temp.length; j++) {
                    if (temp[j] == c) {
                        temp[j] = '1';
                    }
                }
                min = Math.min(min, Integer.parseInt(new String(temp)));
                break;
            }
        }
        return max - min;
    }
}