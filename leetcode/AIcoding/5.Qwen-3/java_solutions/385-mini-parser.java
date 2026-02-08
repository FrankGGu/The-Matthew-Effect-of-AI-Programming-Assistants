public class Solution {

import java.util.*;

public class Solution {
    public NestedInteger deserialize(String s) {
        if (s == null || s.length() == 0) return null;
        if (s.charAt(0) != '[') return new NestedInteger(Integer.parseInt(s));
        return parseNestedInteger(s, 0).nestedInteger;
    }

    private static class ParseResult {
        NestedInteger nestedInteger;
        int index;

        ParseResult(NestedInteger nestedInteger, int index) {
            this.nestedInteger = nestedInteger;
            this.index = index;
        }
    }

    private static ParseResult parseNestedInteger(String s, int start) {
        int i = start + 1;
        NestedInteger result = new NestedInteger();
        while (i < s.length() && s.charAt(i) != ']') {
            if (s.charAt(i) == ',') {
                i++;
                continue;
            }
            if (s.charAt(i) == '[') {
                ParseResult subResult = parseNestedInteger(s, i);
                result.add(subResult.nestedInteger);
                i = subResult.index + 1;
            } else {
                int j = i;
                while (j < s.length() && Character.isDigit(s.charAt(j)) || s.charAt(j) == '-')
                    j++;
                result.add(new NestedInteger(Integer.parseInt(s.substring(i, j))));
                i = j;
            }
        }
        return new ParseResult(result, i);
    }

    public static class NestedInteger {
        private Integer val;
        private List<NestedInteger> list;

        public NestedInteger() {
            this.val = null;
            this.list = new ArrayList<>();
        }

        public NestedInteger(int val) {
            this.val = val;
            this.list = new ArrayList<>();
        }

        public boolean isInteger() {
            return val != null;
        }

        public Integer getInteger() {
            return val;
        }

        public List<NestedInteger> getList() {
            return list;
        }

        public void add(NestedInteger ni) {
            list.add(ni);
        }
    }
}
}