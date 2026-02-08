class Solution {
    public int[] processQueries(int[] queries, int m) {
        List<Integer> permutation = new ArrayList<>();
        for (int i = 1; i <= m; i++) {
            permutation.add(i);
        }
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int query = queries[i];
            int index = permutation.indexOf(query);
            result[i] = index;
            permutation.remove(index);
            permutation.add(0, query);
        }
        return result;
    }
}