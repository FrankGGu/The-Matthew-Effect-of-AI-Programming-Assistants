class Solution {
    public String minimumString(String a, String b, String c) {
        List<String> permutations = new ArrayList<>();
        permutations.add(combine(combine(a, b), c));
        permutations.add(combine(combine(a, c), b));
        permutations.add(combine(combine(b, a), c));
        permutations.add(combine(combine(b, c), a));
        permutations.add(combine(combine(c, a), b));
        permutations.add(combine(combine(c, b), a));

        String result = permutations.get(0);
        for (String s : permutations) {
            if (s.length() < result.length() || (s.length() == result.length() && s.compareTo(result) < 0)) {
                result = s;
            }
        }
        return result;
    }

    private String combine(String s1, String s2) {
        if (s1.contains(s2)) {
            return s1;
        }
        if (s2.contains(s1)) {
            return s2;
        }
        int maxOverlap = Math.min(s1.length(), s2.length());
        for (int i = maxOverlap; i >= 0; i--) {
            if (s1.endsWith(s2.substring(0, i))) {
                return s1 + s2.substring(i);
            }
        }
        return s1 + s2;
    }
}