class Solution {
    public List<List<Integer>> groupThePeople(int[] groupSizes) {
        Map<Integer, List<Integer>> map = new HashMap<>();
        List<List<Integer>> result = new ArrayList<>();

        for (int i = 0; i < groupSizes.length; i++) {
            int size = groupSizes[i];
            if (!map.containsKey(size)) {
                map.put(size, new ArrayList<>());
            }
            List<Integer> group = map.get(size);
            group.add(i);
            if (group.size() == size) {
                result.add(new ArrayList<>(group));
                group.clear();
            }
        }

        return result;
    }
}