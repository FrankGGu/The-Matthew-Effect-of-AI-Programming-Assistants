import java.util.ArrayList;
import java.util.List;

class Solution {
    private List<String> result = new ArrayList<>();
    private String s;
    private int n;

    public List<String> restoreIpAddresses(String s) {
        this.s = s;
        this.n = s.length();

        if (n < 4 || n > 12) {
            return result;
        }

        backtrack(0, 0, new ArrayList<>());
        return result;
    }

    private void backtrack(int startIndex, int segmentCount, List<String> currentParts) {
        if (segmentCount == 4) {
            if (startIndex == n) {
                result.add(String.join(".", currentParts));
            }
            return;
        }

        if (startIndex == n) {
            return;
        }

        int remainingChars = n - startIndex;
        int remainingSegments = 4 - segmentCount;
        if (remainingChars < remainingSegments || remainingChars > remainingSegments * 3) {
            return;
        }

        for (int i = 1; i <= 3; i++) {
            int endIndex = startIndex + i;

            if (endIndex > n) {
                break;
            }

            String segment = s.substring(startIndex, endIndex);

            if (isValidSegment(segment)) {
                currentParts.add(segment);
                backtrack(endIndex, segmentCount + 1, currentParts);
                currentParts.remove(currentParts.size() - 1);
            }
        }
    }

    private boolean isValidSegment(String segment) {
        if (segment.length() == 0 || segment.length() > 3) {
            return false;
        }

        if (segment.length() > 1 && segment.charAt(0) == '0') {
            return false;
        }

        int num = Integer.parseInt(segment);
        return num >= 0 && num <= 255;
    }
}