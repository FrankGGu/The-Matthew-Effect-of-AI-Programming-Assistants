class Solution {
    public int largestVariance(String s) {
        int maxVariance = 0;
        char[] chars = s.toCharArray();
        Set<Character> uniqueChars = new HashSet<>();
        for (char c : chars) {
            uniqueChars.add(c);
        }

        List<Character> charList = new ArrayList<>(uniqueChars);
        int n = charList.size();

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i != j) {
                    char a = charList.get(i);
                    char b = charList.get(j);
                    maxVariance = Math.max(maxVariance, getVariance(s, a, b));
                }
            }
        }

        return maxVariance;
    }

    private int getVariance(String s, char a, char b) {
        int countA = 0, countB = 0, maxVar = 0;
        for (char c : s.toCharArray()) {
            if (c == a) {
                countA++;
            }
            if (c == b) {
                countB++;
            }
            if (countA > 0 && countB > 0) {
                maxVar = Math.max(maxVar, countA - countB);
            }
            if (countB > countA) {
                countA = 0;
                countB = 0;
            }
        }
        return maxVar;
    }
}