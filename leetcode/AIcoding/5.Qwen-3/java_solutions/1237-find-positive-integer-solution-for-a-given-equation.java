public class Solution {

abstract class Solution {
    abstract int f(int x, int y);

    public List<List<Integer>> findSolution(HashFunction hashFunction) {
        List<List<Integer>> result = new ArrayList<>();
        for (int x = 1; x <= 100; x++) {
            for (int y = 1; y <= 100; y++) {
                if (hashFunction.compute(x, y) == 0) {
                    result.add(Arrays.asList(x, y));
                }
            }
        }
        return result;
    }

    @FunctionalInterface
    interface HashFunction {
        int compute(int x, int y);
    }
}
}