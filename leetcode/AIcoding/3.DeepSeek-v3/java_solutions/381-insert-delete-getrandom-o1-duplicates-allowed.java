class RandomizedCollection {
    private List<Integer> list;
    private Map<Integer, Set<Integer>> map;
    private Random random;

    public RandomizedCollection() {
        list = new ArrayList<>();
        map = new HashMap<>();
        random = new Random();
    }

    public boolean insert(int val) {
        boolean contains = map.containsKey(val);
        if (!contains) {
            map.put(val, new LinkedHashSet<>());
        }
        map.get(val).add(list.size());
        list.add(val);
        return !contains;
    }

    public boolean remove(int val) {
        if (!map.containsKey(val)) {
            return false;
        }
        Set<Integer> indices = map.get(val);
        int indexToRemove = indices.iterator().next();
        indices.remove(indexToRemove);
        if (indices.isEmpty()) {
            map.remove(val);
        }
        if (indexToRemove < list.size() - 1) {
            int lastVal = list.get(list.size() - 1);
            list.set(indexToRemove, lastVal);
            Set<Integer> lastValIndices = map.get(lastVal);
            lastValIndices.remove(list.size() - 1);
            lastValIndices.add(indexToRemove);
        }
        list.remove(list.size() - 1);
        return true;
    }

    public int getRandom() {
        return list.get(random.nextInt(list.size()));
    }
}