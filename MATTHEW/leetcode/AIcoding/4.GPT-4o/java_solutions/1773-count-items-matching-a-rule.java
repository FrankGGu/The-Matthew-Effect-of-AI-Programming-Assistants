import java.util.List;

class Solution {
    public int countMatches(List<List<String>> items, String ruleKey, String ruleValue) {
        int count = 0;
        int ruleIndex = getRuleIndex(ruleKey);

        for (List<String> item : items) {
            if (item.get(ruleIndex).equals(ruleValue)) {
                count++;
            }
        }
        return count;
    }

    private int getRuleIndex(String ruleKey) {
        switch (ruleKey) {
            case "type":
                return 0;
            case "color":
                return 1;
            case "name":
                return 2;
            default:
                return -1;
        }
    }
}