class Solution {
    public int[] processQueries(int[] queries, int m) {
        int[] permutation = new int[m];
        for (int i = 0; i < m; i++) {
            permutation[i] = i + 1;
        }
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int index = -1;
            for (int j = 0; j < m; j++) {
                if (permutation[j] == queries[i]) {
                    index = j;
                    break;
                }
            }
            result[i] = index;
            System.arraycopy(permutation, 0, permutation, 1, index);
            permutation[0] = queries[i];
        }
        return result;
    }
}