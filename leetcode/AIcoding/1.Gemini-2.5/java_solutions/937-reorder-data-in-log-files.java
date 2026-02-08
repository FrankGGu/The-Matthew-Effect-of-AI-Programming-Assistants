import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public String[] reorderLogFiles(String[] logs) {
        Comparator<String> myComp = new Comparator<String>() {
            @Override
            public int compare(String log1, String log2) {
                int s1Idx = log1.indexOf(' ');
                String id1 = log1.substring(0, s1Idx);
                String content1 = log1.substring(s1Idx + 1);

                int s2Idx = log2.indexOf(' ');
                String id2 = log2.substring(0, s2Idx);
                String content2 = log2.substring(s2Idx + 1);

                boolean isDigit1 = Character.isDigit(content1.charAt(0));
                boolean isDigit2 = Character.isDigit(content2.charAt(0));

                if (!isDigit1 && !isDigit2) { // Both are letter-logs
                    int cmp = content1.compareTo(content2);
                    if (cmp == 0) {
                        return id1.compareTo(id2);
                    }
                    return cmp;
                } else if (!isDigit1 && isDigit2) { // log1 is letter-log, log2 is digit-log
                    return -1; // letter-log comes before digit-log
                } else if (isDigit1 && !isDigit2) { // log1 is digit-log, log2 is letter-log
                    return 1; // digit-log comes after letter-log
                } else { // Both are digit-logs
                    return 0; // Maintain original order (Arrays.sort is stable for equal elements)
                }
            }
        };

        Arrays.sort(logs, myComp);
        return logs;
    }
}