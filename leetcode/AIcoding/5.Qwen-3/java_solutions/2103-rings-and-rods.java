public class Solution {
    public int countPoints(String rings) {
        int[] red = new int[10];
        int[] green = new int[10];
        int[] blue = new int[10];

        for (int i = 0; i < rings.length(); i += 2) {
            char color = rings.charAt(i);
            int index = rings.charAt(i + 1) - '0';

            if (color == 'R') {
                red[index]++;
            } else if (color == 'G') {
                green[index]++;
            } else if (color == 'B') {
                blue[index]++;
            }
        }

        int count = 0;
        for (int i = 0; i < 10; i++) {
            if (red[i] > 0 && green[i] > 0 && blue[i] > 0) {
                count++;
            }
        }

        return count;
    }
}