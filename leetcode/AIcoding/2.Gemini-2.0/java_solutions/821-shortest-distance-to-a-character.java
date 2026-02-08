class Solution {
    public int[] shortestToChar(String s, char c) {
        int n = s.length();
        int[] result = new int[n];
        List<Integer> cIndices = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == c) {
                cIndices.add(i);
            }
        }

        for (int i = 0; i < n; i++) {
            int minDistance = Integer.MAX_VALUE;
            for (int index : cIndices) {
                minDistance = Math.min(minDistance, Math.abs(i - index));
            }
            result[i] = minDistance;
        }

        return result;
    }
}