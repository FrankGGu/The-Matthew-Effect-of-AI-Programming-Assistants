class Solution {
    public int countPoints(String rings) {
        int[] rod = new int[10];
        for (int i = 0; i < rings.length(); i += 2) {
            char color = rings.charAt(i);
            int index = rings.charAt(i + 1) - '0';
            if (color == 'R') rod[index] |= 1;
            else if (color == 'G') rod[index] |= 2;
            else if (color == 'B') rod[index] |= 4;
        }
        int count = 0;
        for (int r : rod) {
            if (r == 7) count++;
        }
        return count;
    }
}