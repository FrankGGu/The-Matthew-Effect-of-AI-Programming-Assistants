class Solution {
    public boolean areAlmostEqual(String s, String target) {
        int diffCount = 0;
        int[] diffIndices = new int[2];
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) != target.charAt(i)) {
                if (diffCount >= 2) {
                    return false;
                }
                diffIndices[diffCount] = i;
                diffCount++;
            }
        }

        if (diffCount == 0) {
            return true;
        }

        if (diffCount == 2) {
            return (s.charAt(diffIndices[0]) == target.charAt(diffIndices[1]) &&
                    s.charAt(diffIndices[1]) == target.charAt(diffIndices[0]));
        }

        return false;
    }
}