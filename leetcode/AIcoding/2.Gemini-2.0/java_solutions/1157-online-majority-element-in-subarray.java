import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

class MajorityChecker {

    private int[] arr;
    private Map<Integer, List<Integer>> pos;
    private Random random;

    public MajorityChecker(int[] arr) {
        this.arr = arr;
        this.pos = new HashMap<>();
        this.random = new Random();

        for (int i = 0; i < arr.length; i++) {
            pos.computeIfAbsent(arr[i], k -> new ArrayList<>()).add(i);
        }
    }

    public int query(int left, int right, int threshold) {
        for (int i = 0; i < 20; i++) {
            int index = left + random.nextInt(right - left + 1);
            int candidate = arr[index];
            List<Integer> positions = pos.get(candidate);
            if (positions == null) continue;
            int count = binarySearchRight(positions, right) - binarySearchLeft(positions, left) + 1;
            if (count >= threshold) {
                return candidate;
            }
        }
        return -1;
    }

    private int binarySearchLeft(List<Integer> list, int target) {
        int low = 0, high = list.size() - 1;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (list.get(mid) >= target) {
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return low;
    }

    private int binarySearchRight(List<Integer> list, int target) {
        int low = 0, high = list.size() - 1;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (list.get(mid) <= target) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return high;
    }
}