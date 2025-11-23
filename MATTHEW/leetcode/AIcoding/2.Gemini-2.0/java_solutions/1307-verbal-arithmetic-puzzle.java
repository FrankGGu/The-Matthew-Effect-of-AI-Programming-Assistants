class Solution {
    private String[] words;
    private String result;
    private boolean[] used = new boolean[10];
    private int[] charMap = new int[26];
    private String chars;

    public boolean isSolvable(String[] words, String result) {
        this.words = words;
        this.result = result;
        StringBuilder sb = new StringBuilder();
        boolean[] charSet = new boolean[26];

        for (String word : words) {
            for (char c : word.toCharArray()) {
                if (!charSet[c - 'A']) {
                    sb.append(c);
                    charSet[c - 'A'] = true;
                }
            }
        }

        for (char c : result.toCharArray()) {
            if (!charSet[c - 'A']) {
                sb.append(c);
                charSet[c - 'A'] = true;
            }
        }

        this.chars = sb.toString();
        return backtrack(0);
    }

    private boolean backtrack(int index) {
        if (index == chars.length()) {
            return isValid();
        }

        char c = chars.charAt(index);
        for (int i = 0; i <= 9; i++) {
            if (!used[i]) {
                used[i] = true;
                charMap[c - 'A'] = i;
                if (backtrack(index + 1)) {
                    return true;
                }
                used[i] = false;
                charMap[c - 'A'] = 0;
            }
        }

        return false;
    }

    private boolean isValid() {
        long sum = 0;
        for (String word : words) {
            long num = 0;
            for (char c : word.toCharArray()) {
                num = num * 10 + charMap[c - 'A'];
                if (num == 0 && word.length() > 1) return false;

            }
            sum += num;
        }

        long resNum = 0;
        for (char c : result.toCharArray()) {
            resNum = resNum * 10 + charMap[c - 'A'];
            if (resNum == 0 && result.length() > 1) return false;
        }

        return sum == resNum;
    }
}