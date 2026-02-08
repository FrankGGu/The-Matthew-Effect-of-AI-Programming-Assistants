class Solution {
    public List<Integer> solve(int tomatoSlices, int cheeseSlices) {
        int jumbo = (tomatoSlices - 2 * cheeseSlices) / 2;
        int small = cheeseSlices - jumbo;

        if (jumbo < 0 || small < 0 || (tomatoSlices - 2 * cheeseSlices) % 2 != 0) {
            return new ArrayList<>();
        }

        if (4 * jumbo + 2 * small == tomatoSlices && jumbo + small == cheeseSlices) {
            return Arrays.asList(jumbo, small);
        } else {
            return new ArrayList<>();
        }
    }
}