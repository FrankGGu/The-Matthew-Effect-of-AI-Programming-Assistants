public class Solution {
    public NestedInteger deserialize(String s) {
        if (s.charAt(0) != '[') {
            return new NestedInteger(Integer.parseInt(s));
        }
        return deserializeHelper(s, new int[]{0});
    }

    private NestedInteger deserializeHelper(String s, int[] index) {
        NestedInteger ni = new NestedInteger();
        while (index[0] < s.length()) {
            char c = s.charAt(index[0]);
            if (c == '[') {
                index[0]++;
                ni.add(deserializeHelper(s, index));
            } else if (c == ']') {
                index[0]++;
                return ni;
            } else if (c == ',') {
                index[0]++;
            } else {
                int start = index[0];
                while (index[0] < s.length() && s.charAt(index[0]) != ',' && s.charAt(index[0]) != ']') {
                    index[0]++;
                }
                ni.add(new NestedInteger(Integer.parseInt(s.substring(start, index[0]))));
            }
        }
        return ni;
    }
}