import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

class MajorityChecker {
    private int[] arr;
    private Map<Integer, List<Integer>> valToIndices;
    private Random rand;
    private static final int NUM_SAMPLES = 20;

    public MajorityChecker(int[] arr) {
        this.arr = arr;
        this.valToIndices = new HashMap<>();
        this.rand = new Random();

        for (int i = 0; i < arr.length; i++) {
            valToIndices.computeIfAbsent(arr[i], k -> new ArrayList<>()).add(i);
        }
    }

    public int query(int left, int right, int threshold) {
        int rangeLength = right - left + 1;

        for (int i = 0; i < NUM_SAMPLES; i++) {
            int randomIndex = left + rand.nextInt(rangeLength);
            int candidate = arr[randomIndex];

            List<Integer> indices = valToIndices.get(candidate);

            int firstOccurrence = lowerBound(indices, left);
            int lastOccurrence = upperBound(indices, right);

            int count = lastOccurrence - firstOccurrence;

            if (count >= threshold) {
                return candidate;
            }
        }

        return -1;
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