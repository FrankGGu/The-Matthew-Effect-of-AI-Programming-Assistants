class CombinationIterator {
    private String characters;
    private int[] indices;
    private boolean hasNext;

    public CombinationIterator(String characters, int combinationLength) {
        this.characters = characters;
        this.indices = new int[combinationLength];
        for (int i = 0; i < combinationLength; i++) {
            indices[i] = i;
        }
        this.hasNext = true;
    }

    public String next() {
        StringBuilder sb = new StringBuilder();
        for (int index : indices) {
            sb.append(characters.charAt(index));
        }

        int n = characters.length();
        int k = indices.length;
        int i = k - 1;
        while (i >= 0 && indices[i] == n - k + i) {
            i--;
        }
        if (i >= 0) {
            indices[i]++;
            for (int j = i + 1; j < k; j++) {
                indices[j] = indices[i] + j - i;
            }
        } else {
            hasNext = false;
        }
        return sb.toString();
    }

    public boolean hasNext() {
        return hasNext;
    }
}