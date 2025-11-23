public class Solution {
    public int compress(char[] chars) {
        int index = 0;
        int count = 1;
        for (int i = 1; i < chars.length; i++) {
            if (chars[i] == chars[i - 1]) {
                count++;
            } else {
                if (count > 1) {
                    for (char c : String.valueOf(count).toCharArray()) {
                        chars[index++] = c;
                    }
                }
                chars[index++] = chars[i];
                count = 1;
            }
        }
        if (count > 1) {
            for (char c : String.valueOf(count).toCharArray()) {
                chars[index++] = c;
            }
        }
        return index;
    }
}