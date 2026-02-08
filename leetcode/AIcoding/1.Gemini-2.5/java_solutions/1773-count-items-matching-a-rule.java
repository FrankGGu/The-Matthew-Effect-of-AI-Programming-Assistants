class Solution {
    public int countMatches(List<List<String>> items, String ruleKey, String ruleValue) {
        int count = 0;
        int ruleKeyIndex;

        if (ruleKey.equals("type")) {
            ruleKeyIndex = 0;
        } else if (ruleKey.equals("color")) {
            ruleKeyIndex = 1;
        } else { // ruleKey.equals("name")
            ruleKeyIndex = 2;
        }

        for (List<String> item : items) {
            if (item.get(ruleKeyIndex).equals(ruleValue)) {
                count++;
            }
        }

        return count;
    }
}