class Solution {
    public int[] occurrencesOfElement(int[] arr, int[] queries, int x) {
        java.util.List<Integer> occurrences = new java.util.ArrayList<>();
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == x) {
                occurrences.add(i);
            }
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int k = queries[i];
            if (k > 0 && k <= occurrences.size()) {
                result[i] = occurrences.get(k - 1);
            } else {
                result[i] = -1;
            }
        }
        return result;
    }
}