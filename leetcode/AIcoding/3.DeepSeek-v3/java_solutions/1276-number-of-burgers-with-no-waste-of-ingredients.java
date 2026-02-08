class Solution {
    public List<Integer> numOfBurgers(int tomatoSlices, int cheeseSlices) {
        List<Integer> result = new ArrayList<>();
        if (tomatoSlices % 2 != 0 || tomatoSlices < 2 * cheeseSlices || tomatoSlices > 4 * cheeseSlices) {
            return result;
        }
        int jumbo = (tomatoSlices - 2 * cheeseSlices) / 2;
        int small = cheeseSlices - jumbo;
        if (jumbo >= 0 && small >= 0) {
            result.add(jumbo);
            result.add(small);
        }
        return result;
    }
}