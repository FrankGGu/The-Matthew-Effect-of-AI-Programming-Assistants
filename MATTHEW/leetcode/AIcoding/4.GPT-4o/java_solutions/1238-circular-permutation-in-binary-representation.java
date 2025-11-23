class Solution {
    public List<Integer> circularPermutation(int n, int start) {
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < (1 << n); i++) {
            result.add((i ^ (i >> 1)) ^ start);
        }
        return result;
    }
}