class Solution {
    public List<Boolean> prefixesDivBy5(int[] A) {
        List<Boolean> result = new ArrayList<>();
        int current = 0;
        for (int num : A) {
            current = (current << 1) + num;
            result.add(current % 5 == 0);
        }
        return result;
    }
}