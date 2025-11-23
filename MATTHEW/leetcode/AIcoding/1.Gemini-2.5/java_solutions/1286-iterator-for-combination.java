class CombinationIterator {
    private char[] chars;
    private int k;
    private int[] indices;
    private boolean hasMore;

    public CombinationIterator(String characters, int combinationLength) {
        this.chars = characters.toCharArray();
        this.k = combinationLength;
        this.indices = new int[k];

        for (int i = 0; i < k; i++) {
            indices[i] = i;
        }
        this.hasMore = true;
    }

    public String next() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < k; i++) {
            sb.append(chars[indices[i]]);
        }
        String result = sb.toString();

        int i = k - 1;
        while (i >= 0 && indices[i] == chars.length - (k - i)) {
            i--;
        }

        if (i < 0) {
            hasMore = false;
        } else {
            indices[i]++;
            for (int j = i + 1; j < k; j++) {
                indices[j] = indices[j-1] + 1;
            }
        }

        return result;
    }

    public boolean hasNext() {
        return hasMore;
    }
}