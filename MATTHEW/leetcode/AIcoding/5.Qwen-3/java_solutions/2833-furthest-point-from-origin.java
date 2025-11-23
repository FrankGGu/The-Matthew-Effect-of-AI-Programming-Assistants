public class Solution {
    public char furthestPointFromOrigin(String moves) {
        int left = 0;
        int right = 0;
        int up = 0;
        int down = 0;

        for (char c : moves.toCharArray()) {
            if (c == 'L') left++;
            else if (c == 'R') right++;
            else if (c == 'U') up++;
            else if (c == 'D') down++;
        }

        if (left + right >= up + down) {
            return 'L';
        } else {
            return 'U';
        }
    }
}