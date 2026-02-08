class Solution {
    public int numSplits(String s) {
        int n = s.length();
        int[] left = new int[n];
        int[] right = new int[n];
        int[] leftCount = new int[26];
        int[] rightCount = new int[26];
        int leftDistinct = 0;
        int rightDistinct = 0;

        for (int i = 0; i < 26; i++) {
            leftCount[i] = 0;
            rightCount[i] = 0;
        }

        for (int i = 0; i < n; i++) {
            int index = s.charAt(i) - 'a';
            if (leftCount[index] == 0) {
                leftDistinct++;
            }
            leftCount[index]++;
            left[i] = leftDistinct;
        }

        for (int i = n - 1; i >= 0; i--) {
            int index = s.charAt(i) - 'a';
            if (rightCount[index] == 0) {
                rightDistinct++;
            }
            rightCount[index]++;
            right[i] = rightDistinct;
        }

        int count = 0;
        for (int i = 0; i < n - 1; i++) {
            if (left[i] == right[i + 1]) {
                count++;
            }
        }

        return count;
    }
}