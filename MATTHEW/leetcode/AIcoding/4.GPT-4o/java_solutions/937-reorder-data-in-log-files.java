import java.util.Arrays;
import java.util.Comparator;

public class Solution {
    public String[] reorderLogFiles(String[] logs) {
        Arrays.sort(logs, new Comparator<String>() {
            public int compare(String log1, String log2) {
                String[] parts1 = log1.split(" ", 2);
                String[] parts2 = log2.split(" ", 2);
                boolean isDigit1 = Character.isDigit(parts1[1].charAt(0));
                boolean isDigit2 = Character.isDigit(parts2[1].charAt(0));

                if (!isDigit1 && !isDigit2) {
                    int cmp = parts1[1].compareTo(parts2[1]);
                    if (cmp != 0) {
                        return cmp;
                    }
                    return parts1[0].compareTo(parts2[0]);
                }
                return isDigit1 ? (isDigit2 ? 0 : 1) : -1;
            }
        });
        return logs;
    }
}