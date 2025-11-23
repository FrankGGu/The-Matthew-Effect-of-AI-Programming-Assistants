import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class RangeFreqQuery {

    private Map<Integer, List<Integer>> valToIndices;

    public RangeFreqQuery(int[] arr) {
        valToIndices = new HashMap<>();
        for (int i = 0; i < arr.length; i++) {
            valToIndices.computeIfAbsent(arr[i], k -> new ArrayList<>()).add(i);
        }
    }

    public int query(int left, int right, int value) {
        List<Integer> indices = valToIndices.get(value);
        if (indices == null || indices.isEmpty()) {
            return 0;
        }

        int firstOccurrenceIdx = lowerBound(indices, left);
        int firstElementAfterRightIdx = upperBound(indices, right);

        return firstElementAfterRightIdx - firstOccurrenceIdx;
    }

    private int lowerBound(List<Integer> list, int target) {
        int low = 0;
        int high = list.size();
        while (low < high) {
            int mid = low + (high - low) / 2;
            if (list.get(mid) < target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }

    private int upperBound(List<Integer> list, int target) {
        int low = 0;
        int high = list.size();
        while (low < high) {
            int mid = low + (high - low) / 2;
            if (list.get(mid) <= target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }
}