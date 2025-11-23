class Solution {
    public List<Integer> relocateMarbles(int[] nums, int[] moveFrom, int[] moveTo) {
        Set<Integer> positions = new HashSet<>();
        for (int num : nums) {
            positions.add(num);
        }

        for (int i = 0; i < moveFrom.length; i++) {
            if (positions.contains(moveFrom[i])) {
                positions.remove(moveFrom[i]);
                positions.add(moveTo[i]);
            }
        }

        List<Integer> result = new ArrayList<>(positions);
        Collections.sort(result);
        return result;
    }
}