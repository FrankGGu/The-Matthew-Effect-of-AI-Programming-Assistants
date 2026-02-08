class Solution {
    public int getMinSwaps(String num, int k) {
        String target = getKthPermutation(num, k);
        return calculateMinSwaps(num, target);
    }

    private String getKthPermutation(String num, int k) {
        char[] chars = num.toCharArray();
        Arrays.sort(chars);
        StringBuilder sb = new StringBuilder(new String(chars));
        for (int i = 1; i < k; i++) {
            sb = new StringBuilder(nextPermutation(sb.toString()));
        }
        return sb.toString();
    }

    private String nextPermutation(String s) {
        char[] chars = s.toCharArray();
        int i = chars.length - 2;
        while (i >= 0 && chars[i] >= chars[i + 1]) {
            i--;
        }
        if (i >= 0) {
            int j = chars.length - 1;
            while (chars[j] <= chars[i]) {
                j--;
            }
            swap(chars, i, j);
        }
        reverse(chars, i + 1);
        return new String(chars);
    }

    private void swap(char[] chars, int i, int j) {
        char temp = chars[i];
        chars[i] = chars[j];
        chars[j] = temp;
    }

    private void reverse(char[] chars, int start) {
        int end = chars.length - 1;
        while (start < end) {
            swap(chars, start++, end--);
        }
    }

    private int calculateMinSwaps(String num, String target) {
        char[] numChars = num.toCharArray();
        char[] targetChars = target.toCharArray();
        int swaps = 0;
        for (int i = 0; i < numChars.length; i++) {
            if (numChars[i] != targetChars[i]) {
                int j = i + 1;
                while (j < numChars.length && numChars[j] != targetChars[i]) {
                    j++;
                }
                while (j > i) {
                    swap(numChars, j, j - 1);
                    swaps++;
                    j--;
                }
            }
        }
        return swaps;
    }
}