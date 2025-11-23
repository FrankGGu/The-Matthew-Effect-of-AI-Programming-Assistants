public class Solution {

import java.util.*;

public class Solution {
    public String[] reorderLogFiles(String[] logs) {
        Arrays.sort(logs, (a, b) -> {
            int aSplit = findFirstDigitIndex(a);
            int bSplit = findFirstDigitIndex(b);

            boolean aIsLetter = aSplit == -1;
            boolean bIsLetter = bSplit == -1;

            if (aIsLetter && bIsLetter) {
                String aContent = a.substring(0, aSplit);
                String bContent = b.substring(0, bSplit);
                int cmp = aContent.compareTo(bContent);
                if (cmp != 0) return cmp;
                return a.compareTo(b);
            } else if (aIsLetter) {
                return -1;
            } else if (bIsLetter) {
                return 1;
            } else {
                return a.compareTo(b);
            }
        });

        return logs;
    }

    private int findFirstDigitIndex(String s) {
        for (int i = 0; i < s.length(); i++) {
            if (Character.isDigit(s.charAt(i))) {
                return i;
            }
        }
        return -1;
    }
}
}