import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<Integer>> groupThePeople(int[] groupSizes) {
        List<List<Integer>> result = new ArrayList<>();
        List<List<Integer>> groups = new ArrayList<>();

        for (int i = 0; i <= groupSizes.length; i++) {
            groups.add(new ArrayList<>());
        }

        for (int i = 0; i < groupSizes.length; i++) {
            int size = groupSizes[i];
            groups.get(size).add(i);

            if (groups.get(size).size() == size) {
                result.add(new ArrayList<>(groups.get(size)));
                groups.get(size).clear();
            }
        }

        return result;
    }
}