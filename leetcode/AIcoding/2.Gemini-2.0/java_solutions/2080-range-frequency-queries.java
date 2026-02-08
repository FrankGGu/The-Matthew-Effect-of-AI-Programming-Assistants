import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class RangeFreqQuery {

    private Map<Integer, List<Integer>> map;

    public RangeFreqQuery(int[] arr) {
        map = new HashMap<>();
        for (int i = 0; i < arr.length; i++) {
            if (!map.containsKey(arr[i])) {
                map.put(arr[i], new ArrayList<>());
            }
            map.get(arr[i]).add(i);
        }
    }

    public int query(int left, int right, int value) {
        if (!map.containsKey(value)) {
            return 0;
        }

        List<Integer> indices = map.get(value);
        int count = 0;
        int start = 0;
        int end = indices.size() - 1;

        while (start <= end) {
            int mid = start + (end - start) / 2;
            if (indices.get(mid) < left) {
                start = mid + 1;
            } else {
                end = mid - 1;
            }
        }

        int leftIndex = start;

        start = 0;
        end = indices.size() - 1;

        while (start <= end) {
            int mid = start + (end - start) / 2;
            if (indices.get(mid) > right) {
                end = mid - 1;
            } else {
                start = mid + 1;
            }
        }

        int rightIndex = end;

        if (leftIndex <= rightIndex) {
            count = rightIndex - leftIndex + 1;
        }

        return count;
    }
}