import java.util.*;

class RandomizedCollection {
    private List<Integer> nums;
    private Map<Integer, Set<Integer>> indexMap;
    private Random rand;

    public RandomizedCollection() {
        nums = new ArrayList<>();
        indexMap = new HashMap<>();
        rand = new Random();
    }

    public boolean insert(int val) {
        boolean isNew = !indexMap.containsKey(val);
        if (!indexMap.containsKey(val)) {
            indexMap.put(val, new HashSet<>());
        }
        indexMap.get(val).add(nums.size());
        nums.add(val);
        return isNew;
    }

    public boolean remove(int val) {
        if (!indexMap.containsKey(val) || indexMap.get(val).isEmpty()) {
            return false;
        }
        int indexToRemove = indexMap.get(val).iterator().next();
        indexMap.get(val).remove(indexToRemove);

        if (indexToRemove < nums.size() - 1) {
            int lastVal = nums.get(nums.size() - 1);
            nums.set(indexToRemove, lastVal);
            indexMap.get(lastVal).remove(nums.size() - 1);
            indexMap.get(lastVal).add(indexToRemove);
        }

        nums.remove(nums.size() - 1);

        if (indexMap.get(val).isEmpty()) {
            indexMap.remove(val);
        }

        return true;
    }

    public int getRandom() {
        return nums.get(rand.nextInt(nums.size()));
    }
}