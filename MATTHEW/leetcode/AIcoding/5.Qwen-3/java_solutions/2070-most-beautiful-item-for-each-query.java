public class Solution {

import java.util.*;

public class Solution {
    public static int[] sortItems(int n, int m, int[][] group, String[] itemCategory) {
        Map<Integer, List<Integer>> groupToItems = new HashMap<>();
        Map<Integer, List<Integer>> categoryToItems = new HashMap<>();

        for (int i = 0; i < n; i++) {
            int groupId = group[i];
            int categoryId = Integer.parseInt(itemCategory[i]);

            if (!groupToItems.containsKey(groupId)) {
                groupToItems.put(groupId, new ArrayList<>());
            }
            groupToItems.get(groupId).add(i);

            if (!categoryToItems.containsKey(categoryId)) {
                categoryToItems.put(categoryId, new ArrayList<>());
            }
            categoryToItems.get(categoryId).add(i);
        }

        List<int[]> result = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            int groupId = group[i];
            int categoryId = Integer.parseInt(itemCategory[i]);
            int count = 0;

            if (groupToItems.containsKey(groupId)) {
                count += groupToItems.get(groupId).size();
            }

            if (categoryToItems.containsKey(categoryId)) {
                count += categoryToItems.get(categoryId).size();
            }

            result.add(new int[]{i, count});
        }

        result.sort((a, b) -> {
            if (b[1] != a[1]) {
                return b[1] - a[1];
            } else {
                return a[0] - b[0];
            }
        });

        int[] output = new int[n];
        for (int i = 0; i < n; i++) {
            output[result.get(i)[0]] = i + 1;
        }

        return output;
    }

    public static int[] mostBeautifulItem(int[][] items, int[][] queries) {
        Arrays.sort(items, (a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            } else {
                return a[1] - b[1];
            }
        });

        int[] maxBeauty = new int[items.length];
        int max = 0;
        for (int i = 0; i < items.length; i++) {
            max = Math.max(max, items[i][1]);
            maxBeauty[i] = max;
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int price = queries[i][0];
            int index = Arrays.binarySearch(items, new int[]{price, 0}, (a, b) -> a[0] - b[0]);
            if (index >= 0) {
                result[i] = maxBeauty[index];
            } else {
                index = ~index;
                if (index > 0) {
                    result[i] = maxBeauty[index - 1];
                } else {
                    result[i] = 0;
                }
            }
        }

        return result;
    }

    public static void main(String[] args) {
        int[][] items = {{1, 2}, {1, 3}, {1, 4}, {2, 3}, {2, 4}, {3, 5}};
        int[][] queries = {{1, 3}, {2, 3}, {3, 5}};
        int[] result = mostBeautifulItem(items, queries);
        for (int r : result) {
            System.out.print(r + " ");
        }
    }
}
}