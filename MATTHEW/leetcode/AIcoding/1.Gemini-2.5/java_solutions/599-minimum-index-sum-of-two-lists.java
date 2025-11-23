import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public String[] findRestaurant(String[] list1, String[] list2) {
        Map<String, Integer> map1 = new HashMap<>();
        for (int i = 0; i < list1.length; i++) {
            map1.put(list1[i], i);
        }

        List<String> result = new ArrayList<>();
        int minSum = Integer.MAX_VALUE;

        for (int j = 0; j < list2.length; j++) {
            String restaurant = list2[j];
            if (map1.containsKey(restaurant)) {
                int i = map1.get(restaurant);
                int currentSum = i + j;

                if (currentSum < minSum) {
                    minSum = currentSum;
                    result.clear();
                    result.add(restaurant);
                } else if (currentSum == minSum) {
                    result.add(restaurant);
                }
            }
        }

        return result.toArray(new String[0]);
    }
}